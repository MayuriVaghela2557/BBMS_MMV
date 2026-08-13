using System;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnContactSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblContactMessage.Text = "Form validated successfully. Backend functionality will be implemented in Phase 3.";
                lblContactMessage.ForeColor = Color.Green;
            }
        }
    }
}
