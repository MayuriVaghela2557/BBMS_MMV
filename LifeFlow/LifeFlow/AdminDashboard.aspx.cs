using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace LifeFlow
{
    public partial class AdminDashboard : System.Web.UI.Page
    {

        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            //// Dashboard values set to 0 as requested
            //lblTotalDonors.Text = "0";
            //lblTotalUsers.Text = "0";
            //lblTotalHospitals.Text = "0";
            //lblPendingRequests.Text = "0";
            //lblTotalStock.Text = "0 Units";

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        void LoadDashboardData()
        {
            using (SqlConnection con = new SqlConnection(s))
            {
                con.Open();

                // Total Donors
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM donors_tbl", con))
                {
                    lblTotalDonors.Text = cmd.ExecuteScalar().ToString();
                }

                // Total Users
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM ragistration_tbl", con))
                {
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }

                // Total Hospitals
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM hospital_tbl", con))
                {
                    lblTotalHospitals.Text = cmd.ExecuteScalar().ToString();
                }

                // Pending Requests
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM blood_requests_tbl WHERE Status = 'Pending'", con))
                {
                    lblPendingRequests.Text = cmd.ExecuteScalar().ToString();
                }

                // Total Stock Units
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT ISNULL(SUM(UnitsAvailable), 0) FROM blood_stock_tbl", con))
                {
                    lblTotalStock.Text = cmd.ExecuteScalar().ToString() + " Units";
                }
            }
        }
    }
}
