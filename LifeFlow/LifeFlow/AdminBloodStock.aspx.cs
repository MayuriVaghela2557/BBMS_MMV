using System;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class AdminBloodStock : System.Web.UI.Page
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
            da = new SqlDataAdapter("SELECT StockId, BloodGroup, UnitsAvailable, LastUpdated FROM blood_stock_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            ddlStockBloodGroup.SelectedIndex = -1;
            txtStockUnits.Text = "";
           

        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from blood_requests_tbl where StockId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring

            ddlStockBloodGroup.Text = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
            txtStockUnits.Text = ds.Tables[0].Rows[0]["UnitsAvailable"].ToString();
           


            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openAddDonorModal();", true);
        }



        protected void btnSaveStock_Click(object sender, EventArgs e)
        {

            if (btnSaveStock.Text == "Add stock")
            {
                getcon();
                cmd = new SqlCommand("insert into blood_stock_tbl(BloodGroup,UnitsAvailable)values('" + ddlStockBloodGroup.SelectedValue + "','" + txtStockUnits.Text + "')", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('blood request create Successfully')</script>");
                fillGrid();
                
                clear();

            }
            else
            {
                //update
                getcon();
                cmd = new SqlCommand("update blood_stock_tbl set BloodGroup='" + ddlStockBloodGroup.SelectedValue + "', UnitsAvailable='" + txtStockUnits.Text + "' where StockId='" + ViewState["id"] + "'", con);
                Response.Write("<script>alert('requests Edit Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnSaveStock.Text = "Update Inventory";
            }
        }
    }
}
