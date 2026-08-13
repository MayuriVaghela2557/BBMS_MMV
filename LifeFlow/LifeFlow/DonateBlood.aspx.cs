using System;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class DonateBlood : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnDonateSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblDonateMessage.Text = "Form validated successfully. Backend functionality will be implemented in Phase 3.";
                lblDonateMessage.ForeColor = Color.Green;
            }
        }
    }
}
