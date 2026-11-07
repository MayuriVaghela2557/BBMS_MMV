using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class AdminUsers : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from users_tbl order by UserId asc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlRole.SelectedIndex = 0;
            txtPassword.Text = "";
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from users_tbl where UserId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();

                string role = ds.Tables[0].Rows[0]["Role"].ToString();
                if (ddlRole.Items.FindByValue(role) != null)
                {
                    ddlRole.SelectedValue = role;
                }

                string status = ds.Tables[0].Rows[0]["Status"].ToString();
                if (ddlStatus.Items.FindByValue(status) != null)
                {
                    ddlStatus.SelectedValue = status;
                }

                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();

                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditUserModal();", true);
            }
        }

        protected void btnFilterUsers_Click(object sender, EventArgs e)
        {
            string query = "select * from users_tbl where 1=1";
            if (!string.IsNullOrEmpty(txtSearchUser.Text.Trim()))
            {
                string search = txtSearchUser.Text.Trim().Replace("'", "''");
                query += " and (FullName like '%" + search + "%' or Email like '%" + search + "%' or Phone like '%" + search + "%')";
            }
            if (!string.IsNullOrEmpty(ddlFilterRole.SelectedValue))
            {
                query += " and Role = '" + ddlFilterRole.SelectedValue + "'";
            }
            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                query += " and Status = '" + ddlFilterStatus.SelectedValue + "'";
            }

            query += " order by UserId asc";

            getcon();
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (btnAddUser.Text == "Create Account")
            {
                getcon();
                cmd = new SqlCommand("insert into users_tbl(FullName,Email,Phone,Role,Status,Password) values('" + txtFullName.Text.Trim() + "','" + txtEmail.Text.Trim() + "','" + txtPhone.Text.Trim() + "','" + ddlRole.SelectedValue + "','" + ddlStatus.SelectedValue + "','" + txtPassword.Text + "')", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                Response.Write("<script>alert('User added successfully');</script>");
            }
            else
            {
                getcon();
                cmd = new SqlCommand("update users_tbl set FullName='" + txtFullName.Text.Trim() + "', Email='" + txtEmail.Text.Trim() + "', Phone='" + txtPhone.Text.Trim() + "', Role='" + ddlRole.SelectedValue + "', Status='" + ddlStatus.SelectedValue + "', Password='" + txtPassword.Text + "' where UserId='" + ViewState["id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnAddUser.Text = "Create Account";
                Response.Write("<script>alert('User updated successfully');</script>");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                btnAddUser.Text = "Update";
                filldata();
            }
            else if (e.CommandName == "DeleteUser")
            {
                getcon();
                cmd = new SqlCommand("delete from users_tbl where UserId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('User deleted successfully');</script>");
            }
        }
    }
}
