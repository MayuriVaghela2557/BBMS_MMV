using System;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class RequestBlood : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRequestSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblRequestMessage.Text = "Form validated successfully.";
                lblRequestMessage.ForeColor = Color.Green;
            }
        }
    }
}
