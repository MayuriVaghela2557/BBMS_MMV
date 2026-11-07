using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class DonorRegister : System.Web.UI.Page
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

        void clear()
        {
            txtFullName.Text = "";
            if (txtDOB != null) txtDOB.Text = "";
            ddlGender.SelectedIndex = 0;
            ddlBloodGroup.SelectedIndex = 0;
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtCity.Text = "";
            ddlState.SelectedIndex = 0;
            txtAddress.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text) || string.IsNullOrWhiteSpace(txtPhone.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMsg.Text = "<div class='alert alert-danger' style='padding:10px 14px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Please fill all required fields.</div>";
                return;
            }

            getcon();
            cmd = new SqlCommand("insert into donors_tbl(FullName,Age,Gender,BloodGroup,Mobile,Email,City,State,Address,Password,HealthStatus,CreatedDate) values('" + txtFullName.Text.Trim() + "','20','" + ddlGender.SelectedValue + "','" + ddlBloodGroup.SelectedValue + "','" + txtPhone.Text.Trim() + "','" + txtEmail.Text.Trim() + "','" + txtCity.Text.Trim() + "','" + ddlState.SelectedValue + "','" + txtAddress.Text.Trim() + "','" + txtPassword.Text + "','Fit',GETDATE())", con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Write("<script>alert('Donor Registered Successfully')</script>");
            clear();
            lblMsg.Text = "<div class='alert alert-success' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#dcfce7; color:#15803d;'><strong>Success!</strong> Donor registered successfully. You can now <a href='DonorLogin.aspx' style='color:#15803d; font-weight:bold;'>Login</a>.</div>";
        }
    }
}
