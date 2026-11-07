using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class AdminCamps : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from camps_tbl order by CampId asc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtCampTitle.Text = "";
            txtOrganizer.Text = "";
            txtCampDate.Text = "";
            txtTiming.Text = "";
            txtVenue.Text = "";
            txtCampCity.Text = "";
            txtTargetUnits.Text = "50";
            ddlCampStatus.SelectedIndex = 0;
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from camps_tbl where CampId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtCampTitle.Text = ds.Tables[0].Rows[0]["CampTitle"].ToString();
                txtOrganizer.Text = ds.Tables[0].Rows[0]["Organizer"].ToString();

                DateTime dt;
                if (DateTime.TryParse(ds.Tables[0].Rows[0]["CampDate"].ToString(), out dt))
                {
                    txtCampDate.Text = dt.ToString("yyyy-MM-dd");
                }
                else
                {
                    txtCampDate.Text = ds.Tables[0].Rows[0]["CampDate"].ToString();
                }

                txtTiming.Text = ds.Tables[0].Rows[0]["Timing"].ToString();
                txtVenue.Text = ds.Tables[0].Rows[0]["Venue"].ToString();
                txtCampCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                txtTargetUnits.Text = ds.Tables[0].Rows[0]["TargetUnits"].ToString();

                string status = ds.Tables[0].Rows[0]["Status"].ToString();
                if (ddlCampStatus.Items.FindByValue(status) != null)
                {
                    ddlCampStatus.SelectedValue = status;
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditCampModal();", true);
            }
        }

        protected void btnFilterCamps_Click(object sender, EventArgs e)
        {
            string query = "select * from camps_tbl where 1=1";
            if (!string.IsNullOrEmpty(txtSearchCamp.Text.Trim()))
            {
                string search = txtSearchCamp.Text.Trim().Replace("'", "''");
                query += " and (CampTitle like '%" + search + "%' or Venue like '%" + search + "%' or City like '%" + search + "%' or Organizer like '%" + search + "%')";
            }
            if (!string.IsNullOrEmpty(ddlFilterCampCity.SelectedValue))
            {
                query += " and City = '" + ddlFilterCampCity.SelectedValue + "'";
            }
            if (!string.IsNullOrEmpty(ddlFilterCampStatus.SelectedValue))
            {
                query += " and Status = '" + ddlFilterCampStatus.SelectedValue + "'";
            }

            query += " order by CampId asc";

            getcon();
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnSaveCamp_Click(object sender, EventArgs e)
        {
            if (btnSaveCamp.Text == "Schedule Camp")
            {
                getcon();
                cmd = new SqlCommand("insert into camps_tbl(CampTitle,Organizer,CampDate,Timing,Venue,City,TargetUnits,Status) values('" + txtCampTitle.Text.Trim() + "','" + txtOrganizer.Text.Trim() + "','" + txtCampDate.Text.Trim() + "','" + txtTiming.Text.Trim() + "','" + txtVenue.Text.Trim() + "','" + txtCampCity.Text.Trim() + "','" + txtTargetUnits.Text.Trim() + "','" + ddlCampStatus.SelectedValue + "')", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                Response.Write("<script>alert('Camp scheduled successfully');</script>");
            }
            else
            {
                getcon();
                cmd = new SqlCommand("update camps_tbl set CampTitle='" + txtCampTitle.Text.Trim() + "', Organizer='" + txtOrganizer.Text.Trim() + "', CampDate='" + txtCampDate.Text.Trim() + "', Timing='" + txtTiming.Text.Trim() + "', Venue='" + txtVenue.Text.Trim() + "', City='" + txtCampCity.Text.Trim() + "', TargetUnits='" + txtTargetUnits.Text.Trim() + "', Status='" + ddlCampStatus.SelectedValue + "' where CampId='" + ViewState["id"] + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnSaveCamp.Text = "Schedule Camp";
                Response.Write("<script>alert('Camp updated successfully');</script>");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                btnSaveCamp.Text = "Update";
                filldata();
            }
            else if (e.CommandName == "DeleteCamp")
            {
                getcon();
                cmd = new SqlCommand("delete from camps_tbl where CampId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Camp deleted successfully');</script>");
            }
        }
    }
}
