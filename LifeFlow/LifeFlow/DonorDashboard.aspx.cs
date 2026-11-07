using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class DonorDashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["donor"] == null && Session["donorId"] == null && Session["donorEmail"] == null)
            {
                Response.Redirect("DonorLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                loadDashboardData();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void loadDashboardData()
        {
            string donorId = Session["donorId"] != null ? Session["donorId"].ToString().Trim() : "";
            string userKey = Session["donor"] != null ? Session["donor"].ToString().Trim() : "";
            string userEmail = Session["donorEmail"] != null ? Session["donorEmail"].ToString().Trim() : "";

            getcon();

            // If donorId is empty, look it up
            if (string.IsNullOrEmpty(donorId))
            {
                da = new SqlDataAdapter("select DonorId, FullName, BloodGroup from donors_tbl where Email='" + userEmail + "' or Email='" + userKey + "' or FullName='" + userKey + "' or Mobile='" + userKey + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    donorId = ds.Tables[0].Rows[0]["DonorId"].ToString();
                    Session["donorId"] = donorId;
                    Session["donor"] = ds.Tables[0].Rows[0]["FullName"].ToString();
                    Session["donorBloodGroup"] = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
                }
            }

            // Load Donor Info
            da = new SqlDataAdapter("select * from donors_tbl where DonorId='" + donorId + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblBloodGroup.Text = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
                string lastDate = ds.Tables[0].Rows[0]["LastDonationDate"].ToString();
                lblLastDonationDate.Text = !string.IsNullOrEmpty(lastDate) ? Convert.ToDateTime(lastDate).ToString("dd MMM yyyy") : "None";
            }

            // Total Donations Count
            da = new SqlDataAdapter("select count(*) as TotalCount from donations_tbl where DonorId='" + donorId + "'", con);
            DataSet dsDon = new DataSet();
            da.Fill(dsDon);
            int totalDon = 0;
            if (dsDon.Tables[0].Rows.Count > 0 && dsDon.Tables[0].Rows[0]["TotalCount"] != DBNull.Value)
            {
                totalDon = Convert.ToInt32(dsDon.Tables[0].Rows[0]["TotalCount"]);
            }
            lblTotalDonations.Text = totalDon.ToString();
            lblLivesSaved.Text = (totalDon * 3).ToString();
            lblRewardPoints.Text = (totalDon * 100).ToString();

            // Upcoming Appointments Count
            da = new SqlDataAdapter("select count(*) as AppCount from appointments_tbl where DonorId='" + donorId + "' and Status='Confirmed'", con);
            DataSet dsApp = new DataSet();
            da.Fill(dsApp);
            int appCount = 0;
            if (dsApp.Tables[0].Rows.Count > 0 && dsApp.Tables[0].Rows[0]["AppCount"] != DBNull.Value)
            {
                appCount = Convert.ToInt32(dsApp.Tables[0].Rows[0]["AppCount"]);
            }
            lblUpcomingAppointments.Text = appCount.ToString();

            // Recent Donations Grid
            da = new SqlDataAdapter("select top 5 DonationId, CenterName, BloodGroup, UnitsDonated as Units, DonationDate, Status from donations_tbl where DonorId='" + donorId + "' order by DonationId desc", con);
            DataSet dsGrid = new DataSet();
            da.Fill(dsGrid);
            gvRecentDonations.DataSource = dsGrid;
            gvRecentDonations.DataBind();

            con.Close();
        }
    }
}
