using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class BloodAvailability : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillGrid();
                fillCards();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillCards()
        {
            getcon();
            da = new SqlDataAdapter("select BloodGroup, UnitsAvailable from blood_stock_tbl order by StockId", con);
            ds = new DataSet();
            da.Fill(ds);
            rptBloodCards.DataSource = ds;
            rptBloodCards.DataBind();
            con.Close();
        }

        void fillGrid()
        {
            getcon();
            string query = "select StockId, BloodGroup, UnitsAvailable, ISNULL((select max(LastDonationDate) from donors_tbl where BloodGroup = blood_stock_tbl.BloodGroup), LastUpdated) as LastDonationDate, LastUpdated from blood_stock_tbl where 1=1";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                query += " and BloodGroup like '%" + txtSearch.Text.Trim() + "%'";
            }

            if (!string.IsNullOrEmpty(ddlFilterLevel.SelectedValue))
            {
                if (ddlFilterLevel.SelectedValue == "Sufficient")
                {
                    query += " and UnitsAvailable >= 50";
                }
                else if (ddlFilterLevel.SelectedValue == "Moderate")
                {
                    query += " and UnitsAvailable >= 20 and UnitsAvailable < 50";
                }
                else if (ddlFilterLevel.SelectedValue == "Critical")
                {
                    query += " and UnitsAvailable < 20";
                }
            }

            query += " order by StockId";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            lblLastUpdated.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            con.Close();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterLevel.SelectedIndex = 0;
            fillCards();
            fillGrid();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            fillGrid();
        }
    }
}
