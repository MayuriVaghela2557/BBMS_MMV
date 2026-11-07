using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class DonationAppointment : System.Web.UI.Page
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
            string query = "select * from appointments_tbl where DonorId='" + donorId + "'";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                query += " and (CenterName like '%" + txtSearch.Text.Trim() + "%' or Notes like '%" + txtSearch.Text.Trim() + "%')";
            }

            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                query += " and Status='" + ddlFilterStatus.SelectedValue + "'";
            }

            query += " order by AppointmentId desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        void clear()
        {
            ddlLocationType.SelectedIndex = 0;
            ddlCenter.SelectedIndex = 0;
            txtDate.Text = "";
            ddlTimeSlot.SelectedIndex = 0;
            txtNotes.Text = "";
            ViewState["appId"] = null;
            btnBook.Text = "Confirm Appointment";
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from appointments_tbl where AppointmentId='" + ViewState["appId"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string locType = ds.Tables[0].Rows[0]["CenterType"].ToString();
                string center = ds.Tables[0].Rows[0]["CenterName"].ToString();
                string appDate = ds.Tables[0].Rows[0]["AppointmentDate"].ToString();
                string timeSlot = ds.Tables[0].Rows[0]["TimeSlot"].ToString();
                string notes = ds.Tables[0].Rows[0]["Notes"].ToString();

                if (ddlLocationType.Items.FindByValue(locType) != null)
                    ddlLocationType.SelectedValue = locType;

                if (ddlCenter.Items.FindByValue(center) != null)
                    ddlCenter.SelectedValue = center;

                if (!string.IsNullOrEmpty(appDate))
                    txtDate.Text = Convert.ToDateTime(appDate).ToString("yyyy-MM-dd");

                if (ddlTimeSlot.Items.FindByValue(timeSlot) != null)
                    ddlTimeSlot.SelectedValue = timeSlot;

                txtNotes.Text = notes;

                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openAppModal();", true);
            }
            con.Close();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            fillGrid();
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            string donorId = getDonorId();

            if (btnBook.Text == "Confirm Appointment")
            {
                getcon();
                string appDate = !string.IsNullOrWhiteSpace(txtDate.Text) ? txtDate.Text.Trim() : DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                cmd = new SqlCommand("insert into appointments_tbl(DonorId, CenterName, CenterType, AppointmentDate, TimeSlot, Status, Notes, CreatedDate) values('" + donorId + "', '" + ddlCenter.SelectedValue + "', '" + ddlLocationType.SelectedValue + "', '" + appDate + "', '" + ddlTimeSlot.SelectedValue + "', 'Confirmed', '" + txtNotes.Text.Trim() + "', GETDATE())", con);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Donation Appointment Booked Successfully')</script>");
                fillGrid();
                clear();
            }
            else
            {
                getcon();
                string appDate = !string.IsNullOrWhiteSpace(txtDate.Text) ? txtDate.Text.Trim() : DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                cmd = new SqlCommand("update appointments_tbl set CenterName='" + ddlCenter.SelectedValue + "', CenterType='" + ddlLocationType.SelectedValue + "', AppointmentDate='" + appDate + "', TimeSlot='" + ddlTimeSlot.SelectedValue + "', Notes='" + txtNotes.Text.Trim() + "' where AppointmentId='" + ViewState["appId"] + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Appointment Updated Successfully')</script>");
                fillGrid();
                clear();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditApp")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["appId"] = id;
                btnBook.Text = "Update Appointment";
                filldata();
            }
            else if (e.CommandName == "DeleteApp")
            {
                getcon();
                cmd = new SqlCommand("delete from appointments_tbl where AppointmentId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillGrid();
                Response.Write("<script>alert('Appointment Cancelled Successfully')</script>");
            }
        }
    }
}
