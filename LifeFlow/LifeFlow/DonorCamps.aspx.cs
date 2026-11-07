using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class DonorCamps : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["donor"] == null)
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

        void fillGrid()
        {
            getcon();
            string query = "select * from camps_tbl where 1=1";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                query += " and (CampTitle like '%" + txtSearch.Text.Trim() + "%' or Organizer like '%" + txtSearch.Text.Trim() + "%' or Venue like '%" + txtSearch.Text.Trim() + "%' or City like '%" + txtSearch.Text.Trim() + "%')";
            }

            if (!string.IsNullOrEmpty(ddlCity.SelectedValue))
            {
                query += " and City='" + ddlCity.SelectedValue + "'";
            }

            query += " order by CampId desc";

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
            if (e.CommandName == "RegisterCamp")
            {
                string campId = e.CommandArgument.ToString();
                string donorId = Session["donorId"] != null ? Session["donorId"].ToString() : "";

                getcon();
                da = new SqlDataAdapter("select * from camps_tbl where CampId='" + campId + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string campTitle = ds.Tables[0].Rows[0]["CampTitle"].ToString();
                    string campDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["CampDate"]).ToString("yyyy-MM-dd");
                    string timing = ds.Tables[0].Rows[0]["Timing"].ToString();

                    cmd = new SqlCommand("insert into appointments_tbl(DonorId, CenterName, CenterType, AppointmentDate, TimeSlot, Status, Notes, CreatedDate) values('" + donorId + "', '" + campTitle + "', 'Donation Camp', '" + campDate + "', '" + timing + "', 'Confirmed', 'Camp Registration', GETDATE())", con);
                    cmd.ExecuteNonQuery();

                    Response.Write("<script>alert('Successfully registered for Camp: " + campTitle + "')</script>");
                }
                con.Close();
            }
        }
    }
}
