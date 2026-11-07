using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class AdminBloodRequests : System.Web.UI.Page
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
            string query = "select * from blood_requests_tbl where 1=1";

            if (!string.IsNullOrWhiteSpace(txtSearchRequest.Text))
            {
                query += " and (PatientName like '%" + txtSearchRequest.Text.Trim() + "%' or HospitalName like '%" + txtSearchRequest.Text.Trim() + "%' or City like '%" + txtSearchRequest.Text.Trim() + "%' or ContactPhone like '%" + txtSearchRequest.Text.Trim() + "%')";
            }

            if (!string.IsNullOrEmpty(ddlFilterBloodGroup.SelectedValue))
            {
                query += " and BloodGroup='" + ddlFilterBloodGroup.SelectedValue + "'";
            }

            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                query += " and Status='" + ddlFilterStatus.SelectedValue + "'";
            }

            query += " order by RequestId desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnFilterRequests_Click(object sender, EventArgs e)
        {
            fillGrid();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            txtSearchRequest.Text = "";
            ddlFilterBloodGroup.SelectedIndex = 0;
            ddlFilterStatus.SelectedIndex = 0;
            fillGrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                //update
                getcon();
                cmd = new SqlCommand("update blood_requests_tbl set Status='Approved' where RequestId='" + e.CommandArgument + "'", con);
                Response.Write("<script>alert('Blood Request Approved Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
            }
            else if (e.CommandName == "Reject")
            {
                //update
                getcon();
                cmd = new SqlCommand("update blood_requests_tbl set Status='Rejected' where RequestId='" + e.CommandArgument + "'", con);
                Response.Write("<script>alert('Blood Request Rejected Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
            }
            else if (e.CommandName == "DeleteRequest")
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from blood_requests_tbl where RequestId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Blood Request Deleted Successfully')</script>");
            }
        }

        public string GetStatusBadgeClass(object statusObj)
        {
            string status = statusObj != null ? statusObj.ToString().Trim().ToLower() : "";
            if (status == "approved") return "badge-pill badge-status-approved";
            if (status == "rejected") return "badge-pill badge-status-rejected";
            return "badge-pill badge-status-pending";
        }

        public string GetUrgencyBadgeClass(object urgencyObj)
        {
            string urgency = urgencyObj != null ? urgencyObj.ToString().Trim().ToLower() : "";
            if (urgency == "emergency") return "badge-pill badge-urgency-emergency";
            if (urgency == "urgent") return "badge-pill badge-urgency-urgent";
            return "badge-pill badge-urgency-normal";
        }
    }
}
