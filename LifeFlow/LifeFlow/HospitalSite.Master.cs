using System;

namespace LifeFlow
{
    public partial class HospitalSiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["hospital"] != null)
            {
                lblHospitalName.Text = Session["hospital"].ToString();
            }
            else if (Session["Hospital"] != null)
            {
                lblHospitalName.Text = Session["Hospital"].ToString();
            }
            else if (Session["admin"] != null)
            {
                lblHospitalName.Text = "Admin";
            }
            else
            {
                lblHospitalName.Text = "Hospital";
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
