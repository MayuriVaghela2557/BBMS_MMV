using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class HospitalProfile : System.Web.UI.Page
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
                filldata();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from hospital_tbl where HospitalId='" + Session["HospitalId"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select top 1 * from hospital_tbl", con);
                ds = new DataSet();
                da.Fill(ds);
            }

            ////paring
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["HospitalId"] = ds.Tables[0].Rows[0]["HospitalId"].ToString();
                Session["hospitalId"] = ds.Tables[0].Rows[0]["HospitalId"].ToString();

                lblHospName.Text = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                lblHospCity.Text = ds.Tables[0].Rows[0]["City"].ToString() + ", " + ds.Tables[0].Rows[0]["State"].ToString();
                lblHospEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblHospPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                lblHospAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                lblHospLicense.Text = ds.Tables[0].Rows[0]["LicenseNo"].ToString();

                txtHospName.Text = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                txtLicenseNo.Text = ds.Tables[0].Rows[0]["LicenseNo"].ToString();
                txtContactPerson.Text = ds.Tables[0].Rows[0]["ContactPerson"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                ddlState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                txtPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            //update
            getcon();
            cmd = new SqlCommand("update hospital_tbl set HospitalName='" + txtHospName.Text + "', LicenseNo='" + txtLicenseNo.Text + "', ContactPerson='" + txtContactPerson.Text + "', Email='" + txtEmail.Text + "', Phone='" + txtPhone.Text + "', City='" + txtCity.Text + "', State='" + ddlState.SelectedValue + "', Pincode='" + txtPincode.Text + "', Address='" + txtAddress.Text + "' where HospitalId='" + Session["HospitalId"] + "'", con);
            Response.Write("<script>alert('Profile Updated Successfully')</script>");
            cmd.ExecuteNonQuery();

            lblHospName.Text = txtHospName.Text;
            lblHospCity.Text = txtCity.Text + ", " + ddlState.SelectedValue;
            lblHospEmail.Text = txtEmail.Text;
            lblHospPhone.Text = txtPhone.Text;
            lblHospAddress.Text = txtAddress.Text;
            lblHospLicense.Text = txtLicenseNo.Text;

            Session["Hospital"] = txtHospName.Text;
            Session["hospital"] = txtHospName.Text;
        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNewPass.Text) || txtNewPass.Text != txtConfirmPass.Text)
            {
                Response.Write("<script>alert('Passwords do not match')</script>");
                return;
            }

            //select
            getcon();
            da = new SqlDataAdapter("select * from hospital_tbl where HospitalId='" + Session["HospitalId"] + "' and Password='" + txtCurrentPass.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                Response.Write("<script>alert('Current password is incorrect')</script>");
                return;
            }

            //update
            cmd = new SqlCommand("update hospital_tbl set Password='" + txtNewPass.Text + "' where HospitalId='" + Session["HospitalId"] + "'", con);
            Response.Write("<script>alert('Password Changed Successfully')</script>");
            cmd.ExecuteNonQuery();

            txtCurrentPass.Text = "";
            txtNewPass.Text = "";
            txtConfirmPass.Text = "";
        }
    }
}
