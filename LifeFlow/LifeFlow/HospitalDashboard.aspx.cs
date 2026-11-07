using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class HospitalDashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["hospital"] == null && Session["Hospital"] == null && Session["admin"] == null)
            {
                Response.Redirect("HospitalLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillGrid();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillGrid()
        {
            getcon();

            //Total Blood Stock
            cmd = new SqlCommand("select ISNULL(SUM(UnitsAvailable),0) from blood_stock_tbl", con);
            lblTotalStock.Text = cmd.ExecuteScalar().ToString();

            //Pending Requests
            cmd = new SqlCommand("select COUNT(*) from blood_requests_tbl where Status='Pending'", con);
            lblPendingReq.Text = cmd.ExecuteScalar().ToString();

            //Approved Requests
            cmd = new SqlCommand("select COUNT(*) from blood_requests_tbl where Status='Approved'", con);
            lblApprovedReq.Text = cmd.ExecuteScalar().ToString();

            //Total Donors
            cmd = new SqlCommand("select COUNT(*) from donors_tbl", con);
            lblTotalDonations.Text = cmd.ExecuteScalar().ToString();

            //Critical Stock
            cmd = new SqlCommand("select COUNT(*) from blood_stock_tbl where UnitsAvailable < 15", con);
            lblCriticalStock.Text = cmd.ExecuteScalar().ToString();

            //Recent Requests GridView
            da = new SqlDataAdapter("select top 5 * from blood_requests_tbl order by RequestId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentRequests.DataSource = ds;
            gvRecentRequests.DataBind();

            //Stock Summary Repeater
            da = new SqlDataAdapter("select BloodGroup, UnitsAvailable from blood_stock_tbl order by StockId asc", con);
            DataSet ds2 = new DataSet();
            da.Fill(ds2);
            rptStockSummary.DataSource = ds2;
            rptStockSummary.DataBind();
        }
    }
}
