using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class HospitalReports : System.Web.UI.Page
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

            //summary counts
            cmd = new SqlCommand("select COUNT(*) from hospitalreport_tbl where OperationType='Stock Added'", con);
            lblTotalStockLogs.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select COUNT(*) from hospitalreport_tbl where OperationType='Donation Verified'", con);
            lblTotalDonationsCount.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select COUNT(*) from hospitalreport_tbl where OperationType='Request Fulfilled'", con);
            lblFulfilledRequestsCount.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select ISNULL(SUM(Units),0) from hospitalreport_tbl", con);
            lblTotalUnitsHandled.Text = cmd.ExecuteScalar().ToString() + " Units";

            //select
            da = new SqlDataAdapter("select * from hospitalreport_tbl order by LogId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            applyFilter();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            applyFilter();
        }

        void applyFilter()
        {
            getcon();
            string q = "select * from hospitalreport_tbl where 1=1";

            if (ddlReportType.SelectedValue == "Stock") q += " and OperationType='Stock Added'";
            else if (ddlReportType.SelectedValue == "Donation") q += " and OperationType='Donation Verified'";
            else if (ddlReportType.SelectedValue == "Fulfilled") q += " and OperationType='Request Fulfilled'";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                q += " and (Description like '%" + txtSearch.Text.Trim() + "%' or BloodGroup like '%" + txtSearch.Text.Trim() + "%')";
            }

            q += " order by LogId desc";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewLog")
            {
                Response.Write("<script>alert('Viewing Log #" + e.CommandArgument + "')</script>");
            }
            else if (e.CommandName == "DeleteLog")
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from hospitalreport_tbl where LogId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Report Log Deleted Successfully')</script>");
            }
        }
    }
}
