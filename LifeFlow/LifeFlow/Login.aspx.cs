using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["dbcon"] != null ? ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString : "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("AdminDashboard.aspx");
            }
            else if (Session["hospital"] != null)
            {
                Response.Redirect("HospitalDashboard.aspx");
            }
            else if (Session["donor"] != null)
            {
                Response.Redirect("DonorDashboard.aspx");
            }
        }

        void getcon()
        {
            if (!string.IsNullOrEmpty(s))
            {
                con = new SqlConnection(s);
                con.Open();
            }
        }

        protected void btnLoginSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (!(string.IsNullOrEmpty(txtLoginUsername.Text)) &&
                    !(string.IsNullOrEmpty(txtLoginPassword.Text)))
                {
                    getcon();

                    cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM ragistration_tbl " +
                        "WHERE [Email Address]=@Email AND Password=@Password",
                        con);

                    cmd.Parameters.AddWithValue(
                        "@Email", txtLoginUsername.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Password", txtLoginPassword.Text);

                    int i = Convert.ToInt32(cmd.ExecuteScalar());

                    con.Close();

                    if (i > 0)
                    {
                        string selectedRole = ddlRole.SelectedValue.Trim();

                        if (selectedRole == "Admin")
                        {
                            Session["admin"] = txtLoginUsername.Text.Trim();
                            Response.Redirect("AdminDashboard.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                        else if (selectedRole == "Hospital")
                        {
                            string userEmail = txtLoginUsername.Text.Trim();
                            getcon();
                            SqlCommand cmdH = new SqlCommand("select top 1 HospitalId, HospitalName from hospital_tbl where Email=@Email or HospitalName=@Email", con);
                            cmdH.Parameters.AddWithValue("@Email", userEmail);
                            SqlDataReader rdr = cmdH.ExecuteReader();
                            if (rdr.Read())
                            {
                                string hId = rdr["HospitalId"].ToString();
                                string hName = rdr["HospitalName"].ToString();
                                Session["hospital"] = hName;
                                Session["Hospital"] = hName;
                                Session["hospitalId"] = hId;
                                Session["HospitalId"] = hId;
                            }
                            else
                            {
                                Session["hospital"] = userEmail;
                                Session["Hospital"] = userEmail;
                            }
                            rdr.Close();
                            con.Close();

                            Response.Redirect("HospitalDashboard.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                        else if (selectedRole == "Donor")
                        {
                            string userEmail = txtLoginUsername.Text.Trim();
                            Session["donor"] = userEmail;
                            Session["donorEmail"] = userEmail;

                            getcon();
                            SqlCommand cmdD = new SqlCommand("select top 1 DonorId, FullName, Email, BloodGroup from donors_tbl where Email=@Email or FullName=@Email or Mobile=@Email", con);
                            cmdD.Parameters.AddWithValue("@Email", userEmail);
                            SqlDataReader rdrD = cmdD.ExecuteReader();
                            if (rdrD.Read())
                            {
                                Session["donorId"] = rdrD["DonorId"].ToString();
                                Session["donor"] = rdrD["FullName"].ToString();
                                Session["donorBloodGroup"] = rdrD["BloodGroup"].ToString();
                                rdrD.Close();
                            }
                            else
                            {
                                rdrD.Close();
                                SqlCommand cmdR = new SqlCommand("select top 1 [Full Name], [Email Address], [Blood Group] from ragistration_tbl where [Email Address]=@Email or [Full Name]=@Email", con);
                                cmdR.Parameters.AddWithValue("@Email", userEmail);
                                SqlDataReader rdrR = cmdR.ExecuteReader();
                                if (rdrR.Read())
                                {
                                    Session["donor"] = rdrR["Full Name"].ToString();
                                    Session["donorBloodGroup"] = rdrR["Blood Group"].ToString();
                                }
                                rdrR.Close();
                            }
                            con.Close();

                            Response.Redirect("DonorDashboard.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                        else
                        {
                            lblLoginMessage.Text = "Please select a valid role.";
                            lblLoginMessage.ForeColor = Color.Red;
                        }
                    }
                    else
                    {
                        lblLoginMessage.Text = "Invalid Email or Password.";
                        lblLoginMessage.ForeColor = Color.Red;
                    }
                }
            }
        }
    }
}
