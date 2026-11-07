using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class DonationRecords : System.Web.UI.Page
    {
        private DataTable GetDonationsTable()
        {
            if (Session["HospitalDonationsTable"] != null)
            {
                return (DataTable)Session["HospitalDonationsTable"];
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("DonationId", typeof(int));
            dt.Columns.Add("DonorName", typeof(string));
            dt.Columns.Add("DonorAge", typeof(int));
            dt.Columns.Add("DonorGender", typeof(string));
            dt.Columns.Add("BloodGroup", typeof(string));
            dt.Columns.Add("UnitsDonated", typeof(int));
            dt.Columns.Add("DonationDate", typeof(DateTime));
            dt.Columns.Add("DonorPhone", typeof(string));
            dt.Columns.Add("VerificationStatus", typeof(string));

            dt.Rows.Add(201, "Amit Barot", 26, "Male", "A+", 1, DateTime.Now, "9825012345", "Verified");

            Session["HospitalDonationsTable"] = dt;
            return dt;
        }

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

        void fillGrid()
        {
            DataTable dt = GetDonationsTable();

            string bg = ddlFilterBloodGroup.SelectedValue;
            string ver = ddlFilterVerified.SelectedValue;
            string search = txtSearch.Text.Trim().ToLower();

            DataView dv = dt.DefaultView;
            string filter = "1=1";
            if (!string.IsNullOrEmpty(bg)) filter += " AND BloodGroup = '" + bg + "'";
            if (!string.IsNullOrEmpty(ver)) filter += " AND VerificationStatus = '" + ver + "'";
            if (!string.IsNullOrEmpty(search)) filter += " AND DonorName LIKE '%" + search + "%'";

            dv.RowFilter = filter;
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }

        void clear()
        {
            txtDonorName.Text = "";
            txtDonorAge.Text = "";
            ddlGender.SelectedIndex = 0;
            ddlBloodGroup.SelectedIndex = 0;
            txtUnitsDonated.Text = "";
            txtDonationDate.Text = "";
            txtDonorPhone.Text = "";
            txtDonorEmail.Text = "";
            txtHealthNotes.Text = "";
            btnSaveDonation.Text = "Save Record";
        }

        void filldata()
        {
            //select
            DataTable dt = GetDonationsTable();
            int donId = Convert.ToInt32(ViewState["id"]);

            //paring
            foreach (DataRow r in dt.Rows)
            {
                if (Convert.ToInt32(r["DonationId"]) == donId)
                {
                    txtDonorName.Text = r["DonorName"].ToString();
                    txtDonorAge.Text = r["DonorAge"].ToString();
                    ddlGender.Text = r["DonorGender"].ToString();
                    ddlBloodGroup.Text = r["BloodGroup"].ToString();
                    txtUnitsDonated.Text = r["UnitsDonated"].ToString();
                    if (r["DonationDate"] != DBNull.Value)
                    {
                        txtDonationDate.Text = Convert.ToDateTime(r["DonationDate"]).ToString("yyyy-MM-dd");
                    }
                    txtDonorPhone.Text = r["DonorPhone"].ToString();
                    break;
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openDonationModal();", true);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            fillGrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int donId = Convert.ToInt32(e.CommandArgument);
            DataTable dt = GetDonationsTable();

            if (e.CommandName == "Verify")
            {
                foreach (DataRow r in dt.Rows)
                {
                    if (Convert.ToInt32(r["DonationId"]) == donId)
                    {
                        r["VerificationStatus"] = "Verified";
                        break;
                    }
                }
                Session["HospitalDonationsTable"] = dt;
                Response.Write("<script>alert('Donation record verified successfully')</script>");
                fillGrid();
            }
            else if (e.CommandName == "EditRecord")
            {
                ViewState["id"] = donId;
                btnSaveDonation.Text = "Update Record";
                filldata();
            }
            else if (e.CommandName == "DeleteRecord")
            {
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    if (Convert.ToInt32(dt.Rows[i]["DonationId"]) == donId)
                    {
                        dt.Rows.RemoveAt(i);
                        break;
                    }
                }
                Session["HospitalDonationsTable"] = dt;
                Response.Write("<script>alert('Donation record deleted successfully')</script>");
                fillGrid();
            }
        }

        protected void btnSaveDonation_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtDonorName.Text) || string.IsNullOrEmpty(ddlBloodGroup.SelectedValue))
            {
                Response.Write("<script>alert('Please provide donor name and blood group')</script>");
                return;
            }

            DataTable dt = GetDonationsTable();

            int age = 25;
            int.TryParse(txtDonorAge.Text.Trim(), out age);
            int units = 1;
            int.TryParse(txtUnitsDonated.Text.Trim(), out units);
            string gender = string.IsNullOrEmpty(ddlGender.SelectedValue) ? "Male" : ddlGender.SelectedValue;
            string phone = string.IsNullOrEmpty(txtDonorPhone.Text.Trim()) ? "" : txtDonorPhone.Text.Trim();
            DateTime donDate = DateTime.Now;
            if (!string.IsNullOrEmpty(txtDonationDate.Text))
            {
                DateTime.TryParse(txtDonationDate.Text, out donDate);
            }

            if (btnSaveDonation.Text == "Save Record")
            {
                //insert
                int newId = 201;
                if (dt.Rows.Count > 0)
                {
                    int maxId = 0;
                    foreach (DataRow r in dt.Rows)
                    {
                        int curr = Convert.ToInt32(r["DonationId"]);
                        if (curr > maxId) maxId = curr;
                    }
                    newId = maxId + 1;
                }

                dt.Rows.Add(newId, txtDonorName.Text.Trim(), age, gender, ddlBloodGroup.SelectedValue, units, donDate, phone, "Pending");
                Session["HospitalDonationsTable"] = dt;
                Response.Write("<script>alert('Donation Record Added Successfully')</script>");
                fillGrid();
                clear();
            }
            else
            {
                //update
                int donId = Convert.ToInt32(ViewState["id"]);
                foreach (DataRow r in dt.Rows)
                {
                    if (Convert.ToInt32(r["DonationId"]) == donId)
                    {
                        r["DonorName"] = txtDonorName.Text.Trim();
                        r["DonorAge"] = age;
                        r["DonorGender"] = gender;
                        r["BloodGroup"] = ddlBloodGroup.SelectedValue;
                        r["UnitsDonated"] = units;
                        r["DonationDate"] = donDate;
                        r["DonorPhone"] = phone;
                        break;
                    }
                }
                Session["HospitalDonationsTable"] = dt;
                Response.Write("<script>alert('Donation Record Updated Successfully')</script>");
                fillGrid();
                clear();
            }
        }
    }
}
