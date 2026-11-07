using System;

namespace LifeFlow
{
    public partial class DonorSiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["donor"] != null)
            {
                lblDonorName.Text = Session["donor"].ToString();
            }
            else
            {
                lblDonorName.Text = "Donor";
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("DonorLogin.aspx");
        }
    }
}
