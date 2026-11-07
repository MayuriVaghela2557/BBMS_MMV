using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class HospitalLogin : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblLoginMsg.Text = "<div class='alert alert-danger' style='padding:10px 14px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Please enter username and password.</div>";
                return;
            }

            //select
            getcon();
            da = new SqlDataAdapter("select * from hospital_tbl where Email='" + txtUsername.Text.Trim() + "' and Password='" + txtPassword.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string hName = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                string hId = ds.Tables[0].Rows[0]["HospitalId"].ToString();
                Session["hospital"] = hName;
                Session["Hospital"] = hName;
                Session["hospitalId"] = hId;
                Session["HospitalId"] = hId;
                con.Close();
                Response.Redirect("HospitalDashboard.aspx");
            }
            else
            {
                lblLoginMsg.Text = "<div class='alert alert-danger' style='padding:10px 14px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Invalid username or password.</div>";
            }
        }
    }
}
