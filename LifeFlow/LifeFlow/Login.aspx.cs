using System;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLoginSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblLoginMessage.Text = "Form validated successfully.";
                lblLoginMessage.ForeColor = Color.Green;
            }
        }
    }
}
