using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class ManageBloodStock : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from blood_stock_tbl order by StockId asc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            rptStockCards.DataSource = ds;
            rptStockCards.DataBind();
        }

        void clear()
        {
            ddlBloodGroup.SelectedIndex = 0;
            txtUnits.Text = "";
            txtCollectionDate.Text = "";
            txtExpiryDate.Text = "";
            txtRemarks.Text = "";
        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from blood_stock_tbl where StockId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlBloodGroup.Text = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
                txtUnits.Text = ds.Tables[0].Rows[0]["UnitsAvailable"].ToString();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openStockModal();", true);
        }

        protected void btnSaveStock_Click(object sender, EventArgs e)
        {
            if (btnSaveStock.Text == "Save Stock")
            {
                //insert
                getcon();
                cmd = new SqlCommand("insert into blood_stock_tbl(BloodGroup,UnitsAvailable,LastUpdated)values('" + ddlBloodGroup.SelectedValue + "','" + txtUnits.Text + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')", con);
                Response.Write("<script>alert('Blood Stock Added Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
            }
            else
            {
                //update
                getcon();
                cmd = new SqlCommand("update blood_stock_tbl set BloodGroup='" + ddlBloodGroup.SelectedValue + "', UnitsAvailable='" + txtUnits.Text + "', LastUpdated='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where StockId='" + ViewState["id"] + "'", con);
                Response.Write("<script>alert('Blood Stock Updated Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnSaveStock.Text = "Save Stock";
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditStock")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                ViewState["id"] = id;
                btnSaveStock.Text = "Update";
                filldata();
            }
            else if (e.CommandName == "DeleteStock")
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from blood_stock_tbl where StockId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Blood Stock Deleted Successfully')</script>");
            }
        }
    }
}
