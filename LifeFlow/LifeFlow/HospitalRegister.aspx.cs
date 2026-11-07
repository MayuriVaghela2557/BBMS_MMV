using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class HospitalRegister : System.Web.UI.Page
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
            txtHospitalName.Text = "";
            txtLicenseNo.Text = "";
            txtContactPerson.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtCity.Text = "";
            ddlState.SelectedIndex = 0;
            txtPincode.Text = "";
            txtAddress.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            //insert
            getcon();
            cmd = new SqlCommand("insert into hospital_tbl(HospitalName,Email,Phone,ContactPerson,Address,City,State,Pincode,LicenseNo,Status,Password)values('" + txtHospitalName.Text + "','" + txtEmail.Text + "','" + txtPhone.Text + "','" + txtContactPerson.Text + "','" + txtAddress.Text + "','" + txtCity.Text + "','" + ddlState.SelectedValue + "','" + txtPincode.Text + "','" + txtLicenseNo.Text + "','Active','" + txtPassword.Text + "')", con);
            Response.Write("<script>alert('Hospital Registered Successfully')</script>");
            cmd.ExecuteNonQuery();
            clear();
        }
    }
}
