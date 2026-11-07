using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class AdminHospitals : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from hospital_tbl order by HospitalId asc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtHospitalName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtContactPerson.Text = "";
            txtAddress.Text = "";
            txtCity.Text = "";
            txtPincode.Text = "";
            txtLicenseNo.Text = "";
            txtPassword.Text = "";
            ddlState.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from hospital_tbl where HospitalId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtHospitalName.Text = ds.Tables[0].Rows[0]["HospitalName"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                txtContactPerson.Text = ds.Tables[0].Rows[0]["ContactPerson"].ToString();
                txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();

                string state = ds.Tables[0].Rows[0]["State"].ToString();
                if (ddlState.Items.FindByValue(state) != null)
                {
                    ddlState.SelectedValue = state;
                }

                txtPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                txtLicenseNo.Text = ds.Tables[0].Rows[0]["LicenseNo"].ToString();

                string status = ds.Tables[0].Rows[0]["Status"].ToString();
                if (ddlStatus.Items.FindByValue(status) != null)
                {
                    ddlStatus.SelectedValue = status;
                }

                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();

                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditHospitalModal();", true);
            }
        }

        protected void btnFilterHospitals_Click(object sender, EventArgs e)
        {
            string query = "select * from hospital_tbl where 1=1";
            if (!string.IsNullOrEmpty(txtSearchHospital.Text.Trim()))
            {
                string search = txtSearchHospital.Text.Trim().Replace("'", "''");
                query += " and (HospitalName like '%" + search + "%' or City like '%" + search + "%' or Phone like '%" + search + "%' or ContactPerson like '%" + search + "%' or Email like '%" + search + "%')";
            }
            if (!string.IsNullOrEmpty(ddlFilterCity.SelectedValue))
            {
                query += " and City = '" + ddlFilterCity.SelectedValue + "'";
            }
            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                query += " and Status = '" + ddlFilterStatus.SelectedValue + "'";
            }

            query += " order by HospitalId asc";

            getcon();
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnAddHospital_Click(object sender, EventArgs e)
        {
            if (btnAddHospital.Text == "Register Hospital")
            {
                getcon();
                cmd = new SqlCommand("insert into hospital_tbl(HospitalName,Email,Phone,ContactPerson,Address,City,State,Pincode,LicenseNo,Status,Password) values('" + txtHospitalName.Text.Trim() + "','" + txtEmail.Text.Trim() + "','" + txtPhone.Text.Trim() + "','" + txtContactPerson.Text.Trim() + "','" + txtAddress.Text.Trim() + "','" + txtCity.Text.Trim() + "','" + ddlState.SelectedValue + "','" + txtPincode.Text.Trim() + "','" + txtLicenseNo.Text.Trim() + "','" + ddlStatus.SelectedValue + "','" + txtPassword.Text + "')", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                Response.Write("<script>alert('Hospital added successfully');</script>");
            }
            else
            {
                getcon();
                cmd = new SqlCommand("update hospital_tbl set HospitalName='" + txtHospitalName.Text.Trim() + "', Email='" + txtEmail.Text.Trim() + "', Phone='" + txtPhone.Text.Trim() + "', ContactPerson='" + txtContactPerson.Text.Trim() + "', Address='" + txtAddress.Text.Trim() + "', City='" + txtCity.Text.Trim() + "', State='" + ddlState.SelectedValue + "', Pincode='" + txtPincode.Text.Trim() + "', LicenseNo='" + txtLicenseNo.Text.Trim() + "', Status='" + ddlStatus.SelectedValue + "', Password='" + txtPassword.Text + "' where HospitalId='" + ViewState["id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnAddHospital.Text = "Register Hospital";
                Response.Write("<script>alert('Hospital updated successfully');</script>");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                btnAddHospital.Text = "Update";
                filldata();
            }
            else if (e.CommandName == "DeleteHospital")
            {
                getcon();
                cmd = new SqlCommand("delete from hospital_tbl where HospitalId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Hospital deleted successfully');</script>");
            }
        }
    }
}
