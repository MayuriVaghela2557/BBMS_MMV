using System;
using System.Configuration;
using System.Data;
//new namesapace
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class Register : Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            fillGrid();

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillGrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from ragistration_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

    void clear()
        {
            txtRegName.Text = "";
            txtRegEmail.Text = "";
            txtRegPhone.Text = "";
            txtRegAge.Text = "";
            ddlRegGender.SelectedIndex= -1;
            ddlRegBloodGroup.SelectedIndex= -1;
            txtRegCity.Text = "";
            txtRegPassword.Text = "";
            txtRegConfirmPassword.Text = "";

        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from ragistration_tbl where Id='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring

            txtRegName.Text = ds.Tables[0].Rows[0]["Full Name"].ToString();
            txtRegEmail.Text = ds.Tables[0].Rows[0]["Email Address"].ToString();
            txtRegPhone.Text = ds.Tables[0].Rows[0]["Phone Number"].ToString();
            txtRegAge.Text = ds.Tables[0].Rows[0]["Age"].ToString();
            ddlRegGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
            ddlRegBloodGroup.Text = ds.Tables[0].Rows[0]["Blood Group"].ToString();
            txtRegCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            txtRegPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
            txtRegConfirmPassword.Text = ds.Tables[0].Rows[0]["Confirm Password"].ToString();
        

        }

        protected void btnRegisterSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblRegisterMessage.Text = "Form validated successfully.";
                lblRegisterMessage.ForeColor = Color.Green;
            }

            if (btnRegisterSubmit.Text=="Register")
            {
                getcon();
                cmd = new SqlCommand("insert into ragistration_tbl([Full Name],[Email Address],[Phone Number],Age,Gender,[Blood Group],City,Password,[Confirm Password])values('"+txtRegName.Text+"','"+txtRegEmail.Text+"','"+txtRegPhone.Text+"','"+txtRegAge.Text+"','"+ddlRegGender.SelectedValue+"','"+ddlRegBloodGroup.SelectedValue+"','"+txtRegCity.Text+"','"+txtRegPassword.Text+"','"+txtRegConfirmPassword.Text+"')", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();

            }
            else
            {
                //update
                getcon();
                cmd = new SqlCommand("update ragistration_tbl set [Full Name]='" + txtRegName.Text + "',[Email Address]='" + txtRegEmail.Text + "',[Phone Number]='" + txtRegPhone.Text + "',Age='" + txtRegAge.Text + "',Gender='" + ddlRegGender.SelectedValue + "',[Blood Group]='" + ddlRegBloodGroup.SelectedValue + "',City='" + txtRegCity.Text + "',Password='" + txtRegPassword.Text + "',[Confirm Password]='" + txtRegConfirmPassword.Text + "' where Id='" + ViewState["id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnRegisterSubmit.Text = "Register";
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                ViewState["id"] = id;
                btnRegisterSubmit.Text = "Update";
                filldata();

            }
            else
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from  ragistration_tbl where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
            }
        }
    }
}
