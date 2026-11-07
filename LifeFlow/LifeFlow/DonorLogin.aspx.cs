using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class DonorLogin : System.Web.UI.Page
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

            getcon();
            da = new SqlDataAdapter("select * from donors_tbl where (Email='" + txtUsername.Text.Trim() + "' or Mobile='" + txtUsername.Text.Trim() + "' or FullName='" + txtUsername.Text.Trim() + "') and Password='" + txtPassword.Text.Trim() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string dName = ds.Tables[0].Rows[0]["FullName"].ToString();
                string dId = ds.Tables[0].Rows[0]["DonorId"].ToString();
                string dEmail = ds.Tables[0].Rows[0]["Email"].ToString();
                string dBlood = ds.Tables[0].Rows[0]["BloodGroup"].ToString();

                Session["donor"] = dName;
                Session["donorId"] = dId;
                Session["donorEmail"] = dEmail;
                Session["donorBloodGroup"] = dBlood;

                con.Close();
                Response.Redirect("DonorDashboard.aspx");
            }
            else
            {
                con.Close();
                lblLoginMsg.Text = "<div class='alert alert-danger' style='padding:10px 14px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Invalid username or password.</div>";
            }
        }
    }
}
