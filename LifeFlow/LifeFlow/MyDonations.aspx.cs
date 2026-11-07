using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class MyDonations : System.Web.UI.Page
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
                fillGrid();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        string getDonorId()
        {
            if (Session["donorId"] != null && !string.IsNullOrEmpty(Session["donorId"].ToString()))
                return Session["donorId"].ToString();

            string userKey = Session["donor"] != null ? Session["donor"].ToString().Trim() : "";
            string userEmail = Session["donorEmail"] != null ? Session["donorEmail"].ToString().Trim() : "";
            getcon();
            da = new SqlDataAdapter("select DonorId from donors_tbl where Email='" + userEmail + "' or Email='" + userKey + "' or FullName='" + userKey + "'", con);
            DataSet dsTemp = new DataSet();
            da.Fill(dsTemp);
            if (dsTemp.Tables[0].Rows.Count > 0)
            {
                string id = dsTemp.Tables[0].Rows[0]["DonorId"].ToString();
                Session["donorId"] = id;
                return id;
            }
            return "0";
        }

        void fillGrid()
        {
            string donorId = getDonorId();

            getcon();
            string query = "select * from donations_tbl where DonorId='" + donorId + "'";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                query += " and (CenterName like '%" + txtSearch.Text.Trim() + "%' or City like '%" + txtSearch.Text.Trim() + "%')";
            }

            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                query += " and Status='" + ddlFilterStatus.SelectedValue + "'";
            }

            query += " order by DonationId desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            fillGrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRec")
            {
                getcon();
                cmd = new SqlCommand("delete from donations_tbl where DonationId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillGrid();
                Response.Write("<script>alert('Donation Record Deleted Successfully')</script>");
            }
            else if (e.CommandName == "ViewCert")
            {
                Response.Write("<script>alert('Blood Donation Certificate for DON-" + e.CommandArgument + " is verified and officially issued.')</script>");
            }
        }
    }
}
