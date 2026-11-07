using System;

namespace LifeFlow
{
    public partial class DonationEligibility : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["donor"] == null)
            {
                Response.Redirect("DonorLogin.aspx");
                return;
            }
        }
    }
}
