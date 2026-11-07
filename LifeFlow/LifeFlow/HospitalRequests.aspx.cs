using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class HospitalRequests : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from blood_requests_tbl order by RequestId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtPatientName.Text = "";
            txtDoctorName.Text = "";
            ddlBloodGroup.SelectedIndex = 0;
            txtUnitsNeeded.Text = "";
            ddlUrgency.SelectedIndex = 0;
            txtRequiredDate.Text = "";
            txtContactPhone.Text = "";
            txtWard.Text = "";
            txtNotes.Text = "";
            txtSearch.Text = "";
            btnSubmitRequest.Text = "Submit Request";
        }

        void filldata()
        {
            //select
            getcon();
            da = new SqlDataAdapter("select * from blood_requests_tbl where RequestId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtPatientName.Text = ds.Tables[0].Rows[0]["PatientName"].ToString();
                txtDoctorName.Text = ds.Tables[0].Rows[0]["DoctorName"].ToString();
                ddlBloodGroup.Text = ds.Tables[0].Rows[0]["BloodGroup"].ToString();
                txtUnitsNeeded.Text = ds.Tables[0].Rows[0]["UnitsNeeded"].ToString();
                ddlUrgency.Text = ds.Tables[0].Rows[0]["Urgency"].ToString();
                txtContactPhone.Text = ds.Tables[0].Rows[0]["ContactPhone"].ToString();
                txtWard.Text = ds.Tables[0].Rows[0]["Ward"].ToString();
                txtNotes.Text = ds.Tables[0].Rows[0]["Notes"].ToString();
                txtRequiredDate.Text = ds.Tables[0].Rows[0]["RequiredDate"].ToString();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openRequestModal();", true);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select * from blood_requests_tbl where 1=1";
            if (!string.IsNullOrEmpty(ddlFilterBloodGroup.SelectedValue))
            {
                q += " and BloodGroup='" + ddlFilterBloodGroup.SelectedValue + "'";
            }
            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                q += " and Status='" + ddlFilterStatus.SelectedValue + "'";
            }
            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                q += " and (PatientName like '%" + txtSearch.Text.Trim() + "%' or ContactPhone like '%" + txtSearch.Text.Trim() + "%')";
            }
            q += " order by RequestId desc";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnSubmitRequest_Click(object sender, EventArgs e)
        {
            string hosp = Session["hospital"] != null ? Session["hospital"].ToString() : (Session["Hospital"] != null ? Session["Hospital"].ToString() : "Hospital");

            if (btnSubmitRequest.Text == "Submit Request")
            {
                //insert
                getcon();
                cmd = new SqlCommand("insert into blood_requests_tbl(PatientName,DoctorName,HospitalName,BloodGroup,UnitsNeeded,Urgency,ContactPhone,Ward,Notes,RequiredDate,City,Status,RequestDate)values('" + txtPatientName.Text + "','" + txtDoctorName.Text + "','" + hosp + "','" + ddlBloodGroup.SelectedValue + "','" + txtUnitsNeeded.Text + "','" + ddlUrgency.SelectedValue + "','" + txtContactPhone.Text + "','" + txtWard.Text + "','" + txtNotes.Text + "','" + txtRequiredDate.Text + "','Ahmedabad','Pending','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')", con);
                Response.Write("<script>alert('Blood Request Submitted Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
            }
            else
            {
                //update
                getcon();
                cmd = new SqlCommand("update blood_requests_tbl set PatientName='" + txtPatientName.Text + "', DoctorName='" + txtDoctorName.Text + "', BloodGroup='" + ddlBloodGroup.SelectedValue + "', UnitsNeeded='" + txtUnitsNeeded.Text + "', Urgency='" + ddlUrgency.SelectedValue + "', ContactPhone='" + txtContactPhone.Text + "', Ward='" + txtWard.Text + "', Notes='" + txtNotes.Text + "', RequiredDate='" + txtRequiredDate.Text + "' where RequestId='" + ViewState["id"] + "'", con);
                Response.Write("<script>alert('Blood Request Updated Successfully')</script>");
                cmd.ExecuteNonQuery();
                fillGrid();
                clear();
                btnSubmitRequest.Text = "Submit Request";
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditReq")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                ViewState["id"] = id;
                btnSubmitRequest.Text = "Update Request";
                filldata();
            }
            else if (e.CommandName == "DeleteReq")
            {
                //Delete
                getcon();
                cmd = new SqlCommand("delete from blood_requests_tbl where RequestId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                Response.Write("<script>alert('Blood Request Deleted Successfully')</script>");
            }
        }
    }
}
