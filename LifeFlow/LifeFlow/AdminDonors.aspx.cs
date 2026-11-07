using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace LifeFlow

{
    public partial class AdminDonors : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from donors_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtDonorName.Text = "";
            txtDonorAge.Text = "";
            txtDonorMobile.Text = "";
            txtDonorEmail.Text = "";
            ddlDonorGender.SelectedIndex = -1;
            ddlDonorBloodGroup.SelectedIndex = -1;
            ddlDonorState.SelectedIndex = -1;
            ddlHealthStatus.SelectedIndex = -1;
            txtDonorCity.Text = "";
            txtDonorPassword.Text = "";
            txtDonorAddress.Text = "";
            txtLastDonationDate.Text = "";
            txtSearchDonor.Text = "";

        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from donors_tbl where DonorId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring

            txtDonorName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            txtDonorAge.Text = ds.Tables[0].Rows[0]["Age"].ToString();
            txtDonorMobile.Text = ds.Tables[0].Rows[0]["Mobile"].ToString();
            txtDonorEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            ddlDonorGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
            ddlDonorBloodGroup.Text = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
            txtDonorCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            txtDonorPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
            ddlDonorState.Text = ds.Tables[0].Rows[0]["State"].ToString();
            txtLastDonationDate.Text = ds.Tables[0].Rows[0]["LastDonationDate"].ToString();
            ddlHealthStatus.Text = ds.Tables[0].Rows[0]["HealthStatus"].ToString();
            txtDonorAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openAddDonorModal();", true);
        }

        protected void btnFilterDonors_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnAddDonor_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //lblMsg.Text = "donor add successfully.";
                //lblMsg.ForeColor = Color.Green;
            }


            if (btnAddDonor.Text == "Save Donor")
            {
                getcon();
                cmd = new SqlCommand("insert into donors_tbl(FullName,Age,Gender,BloodGroup,Mobile,Email,City,State,Address,LastDonationDate,HealthStatus,Password)values('" + txtDonorName.Text + "','" + txtDonorAge.Text + "','" + ddlDonorGender.SelectedValue + "','" + ddlDonorBloodGroup.SelectedValue + "','" + txtDonorMobile.Text + "','" + txtDonorEmail.Text + "','" + txtDonorCity.Text + "','" + ddlDonorState.SelectedValue + "','" + txtDonorAddress.Text + "','" + txtLastDonationDate.Text + "','" + ddlHealthStatus.SelectedValue + "','" + txtDonorPassword.Text + "')", con);
                Response.Write("<script>alert('Donor add Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();

            }
            else
            {
                //update
                getcon();
                cmd = new SqlCommand("update donors_tbl set FullName='" + txtDonorName.Text + "', Age='"+txtDonorAge.Text+"',Gender='"+ddlDonorGender.SelectedValue+"',BloodGroup='"+ddlDonorBloodGroup.SelectedValue+"',Mobile='"+txtDonorMobile.Text+"',Email='"+txtDonorEmail.Text+"',City='"+txtDonorCity.Text+"',State='"+ddlDonorState.SelectedValue+"',Address='"+txtDonorAddress.Text+"',LastDonationDate='"+txtLastDonationDate.Text+"',HealthStatus='"+ddlHealthStatus.SelectedValue+"',Password='"+txtDonorPassword.Text+"' where DonorId='" + ViewState["id"] + "'",con);
                Response.Write("<script>alert('Donor Edit Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnAddDonor.Text = "Save Donor";
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                ViewState["id"] = id;
                btnAddDonor.Text = "Update";
                filldata();
               

            }
            else if (e.CommandName == "DeleteDonor")
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from  donors_tbl where DonorId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Donor Delete Successfully')</script>");
            }
        }

        protected void gGridView1_SelectedIndexChaned(object sender, EventArgs e)
        {

        }

        protected void ddlFilterCity_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
    
}
