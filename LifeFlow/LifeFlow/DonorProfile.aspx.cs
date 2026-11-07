using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace LifeFlow
{
    public partial class DonorProfile : System.Web.UI.Page
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
                fillProfile();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillProfile()
        {
            string donorId = Session["donorId"] != null ? Session["donorId"].ToString().Trim() : "";
            string userKey = Session["donor"] != null ? Session["donor"].ToString().Trim() : "";
            string userEmail = Session["donorEmail"] != null ? Session["donorEmail"].ToString().Trim() : "";

            getcon();

            // 1. Try finding in donors_tbl
            string q = "select * from donors_tbl where 1=2";
            if (!string.IsNullOrEmpty(donorId))
            {
                q += " or DonorId='" + donorId + "'";
            }
            if (!string.IsNullOrEmpty(userEmail))
            {
                q += " or Email='" + userEmail + "'";
            }
            if (!string.IsNullOrEmpty(userKey))
            {
                q += " or Email='" + userKey + "' or Mobile='" + userKey + "' or FullName='" + userKey + "'";
            }

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string id = ds.Tables[0].Rows[0]["DonorId"].ToString();
                string name = ds.Tables[0].Rows[0]["FullName"].ToString();
                string email = ds.Tables[0].Rows[0]["Email"].ToString();
                string mobile = ds.Tables[0].Rows[0]["Mobile"].ToString();
                string city = ds.Tables[0].Rows[0]["City"].ToString();
                string state = ds.Tables[0].Rows[0]["State"].ToString();
                string bg = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
                string address = ds.Tables[0].Rows[0]["Address"].ToString();

                ViewState["donorId"] = id;
                Session["donorId"] = id;
                Session["donorEmail"] = email;

                // Left card labels
                lblCardName.Text = name;
                lblCardCity.Text = city + (!string.IsNullOrEmpty(state) ? ", " + state : "");
                lblCardBloodGroup.Text = bg;
                lblCardEmail.Text = email;
                lblCardPhone.Text = mobile;
                lblCardAddress.Text = address;

                // Form textboxes
                txtFullName.Text = name;
                txtBloodGroup.Text = bg;
                txtPhone.Text = mobile;
                txtEmail.Text = email;
                txtCity.Text = city;
                if (ddlState.Items.FindByValue(state) != null)
                {
                    ddlState.SelectedValue = state;
                }
                txtAddress.Text = address;
            }
            else
            {
                // 2. If not found in donors_tbl, find in ragistration_tbl
                da = new SqlDataAdapter("select * from ragistration_tbl where [Email Address]='" + userKey + "' or [Email Address]='" + userEmail + "' or [Phone Number]='" + userKey + "' or [Full Name]='" + userKey + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string name = ds.Tables[0].Rows[0]["Full Name"].ToString();
                    string email = ds.Tables[0].Rows[0]["Email Address"].ToString();
                    string mobile = ds.Tables[0].Rows[0]["Phone Number"].ToString();
                    string city = ds.Tables[0].Rows[0]["City"].ToString();
                    string bg = ds.Tables[0].Rows[0]["Blood Group"].ToString();
                    string age = ds.Tables[0].Rows[0]["Age"].ToString();
                    string gender = ds.Tables[0].Rows[0]["Gender"].ToString();
                    string pass = ds.Tables[0].Rows[0]["Password"].ToString();

                    // Sync into donors_tbl
                    cmd = new SqlCommand("insert into donors_tbl(FullName,Age,Gender,BloodGroup,Mobile,Email,City,State,Address,Password,HealthStatus,CreatedDate) values('" + name + "','" + age + "','" + gender + "','" + bg + "','" + mobile + "','" + email + "','" + city + "','Gujarat','" + city + "','" + pass + "','Fit',GETDATE()); select SCOPE_IDENTITY();", con);
                    object newId = cmd.ExecuteScalar();
                    string id = newId != null ? newId.ToString() : "0";

                    ViewState["donorId"] = id;
                    Session["donorId"] = id;
                    Session["donorEmail"] = email;

                    // Left card labels
                    lblCardName.Text = name;
                    lblCardCity.Text = city + ", Gujarat";
                    lblCardBloodGroup.Text = bg;
                    lblCardEmail.Text = email;
                    lblCardPhone.Text = mobile;
                    lblCardAddress.Text = city;

                    // Form textboxes
                    txtFullName.Text = name;
                    txtBloodGroup.Text = bg;
                    txtPhone.Text = mobile;
                    txtEmail.Text = email;
                    txtCity.Text = city;
                    txtAddress.Text = city;
                }
            }
            con.Close();
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            string donorId = ViewState["donorId"] != null ? ViewState["donorId"].ToString() : (Session["donorId"] != null ? Session["donorId"].ToString() : "");
            string userEmail = Session["donorEmail"] != null ? Session["donorEmail"].ToString() : (Session["donor"] != null ? Session["donor"].ToString() : "");

            getcon();

            // 1. Update donors_tbl
            if (!string.IsNullOrEmpty(donorId))
            {
                cmd = new SqlCommand("update donors_tbl set FullName='" + txtFullName.Text.Trim() + "', Mobile='" + txtPhone.Text.Trim() + "', Email='" + txtEmail.Text.Trim() + "', City='" + txtCity.Text.Trim() + "', State='" + ddlState.SelectedValue + "', Address='" + txtAddress.Text.Trim() + "' where DonorId='" + donorId + "'", con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                cmd = new SqlCommand("update donors_tbl set FullName='" + txtFullName.Text.Trim() + "', Mobile='" + txtPhone.Text.Trim() + "', Email='" + txtEmail.Text.Trim() + "', City='" + txtCity.Text.Trim() + "', State='" + ddlState.SelectedValue + "', Address='" + txtAddress.Text.Trim() + "' where Email='" + userEmail + "' or FullName='" + userEmail + "'", con);
                cmd.ExecuteNonQuery();
            }

            // 2. Also update ragistration_tbl
            cmd = new SqlCommand("update ragistration_tbl set [Full Name]='" + txtFullName.Text.Trim() + "', [Phone Number]='" + txtPhone.Text.Trim() + "', [Email Address]='" + txtEmail.Text.Trim() + "', City='" + txtCity.Text.Trim() + "' where [Email Address]='" + userEmail + "' or [Email Address]='" + txtEmail.Text.Trim() + "'", con);
            cmd.ExecuteNonQuery();

            con.Close();

            Session["donor"] = txtFullName.Text.Trim();
            Session["donorEmail"] = txtEmail.Text.Trim();

            Response.Write("<script>alert('Donor Profile Updated Successfully')</script>");
            fillProfile();
            lblMsg.Text = "<div class='alert alert-success' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#dcfce7; color:#15803d;'><strong>Success!</strong> Profile updated successfully.</div>";
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string donorId = ViewState["donorId"] != null ? ViewState["donorId"].ToString() : (Session["donorId"] != null ? Session["donorId"].ToString() : "");
            string userEmail = Session["donorEmail"] != null ? Session["donorEmail"].ToString() : (Session["donor"] != null ? Session["donor"].ToString() : "");

            if (string.IsNullOrWhiteSpace(txtCurrentPass.Text) || string.IsNullOrWhiteSpace(txtNewPass.Text))
            {
                lblMsg.Text = "<div class='alert alert-danger' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Please fill all password fields.</div>";
                return;
            }

            if (txtNewPass.Text != txtConfirmPass.Text)
            {
                lblMsg.Text = "<div class='alert alert-danger' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>New password and confirm password do not match.</div>";
                return;
            }

            getcon();

            // Verify current password
            string qCheck = !string.IsNullOrEmpty(donorId)
                ? "select * from donors_tbl where DonorId='" + donorId + "' and Password='" + txtCurrentPass.Text + "'"
                : "select * from donors_tbl where (Email='" + userEmail + "' or FullName='" + userEmail + "') and Password='" + txtCurrentPass.Text + "'";

            da = new SqlDataAdapter(qCheck, con);
            ds = new DataSet();
            da.Fill(ds);

            bool matched = false;
            if (ds.Tables[0].Rows.Count > 0)
            {
                matched = true;
            }
            else
            {
                da = new SqlDataAdapter("select * from ragistration_tbl where [Email Address]='" + userEmail + "' and Password='" + txtCurrentPass.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    matched = true;
                }
            }

            if (matched)
            {
                if (!string.IsNullOrEmpty(donorId))
                {
                    cmd = new SqlCommand("update donors_tbl set Password='" + txtNewPass.Text + "' where DonorId='" + donorId + "'", con);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd = new SqlCommand("update donors_tbl set Password='" + txtNewPass.Text + "' where Email='" + userEmail + "' or FullName='" + userEmail + "'", con);
                    cmd.ExecuteNonQuery();
                }

                cmd = new SqlCommand("update ragistration_tbl set Password='" + txtNewPass.Text + "', [Confirm Password]='" + txtNewPass.Text + "' where [Email Address]='" + userEmail + "' or [Email Address]='" + txtEmail.Text.Trim() + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Password Changed Successfully')</script>");
                lblMsg.Text = "<div class='alert alert-success' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#dcfce7; color:#15803d;'><strong>Success!</strong> Password updated successfully.</div>";
                txtCurrentPass.Text = "";
                txtNewPass.Text = "";
                txtConfirmPass.Text = "";
            }
            else
            {
                con.Close();
                lblMsg.Text = "<div class='alert alert-danger' style='padding:12px; border-radius:8px; margin-bottom:15px; background:#fee2e2; color:#b91c1c;'>Current password is incorrect.</div>";
            }
        }
    }
}
