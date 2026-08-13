using System;
using System.Drawing;
using System.Web.UI;

namespace LifeFlow
{
    public partial class BloodAvailability : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblSearchMessage.Text = "Search performed. Live database query functionality will be implemented in Phase 3.";
            lblSearchMessage.ForeColor = Color.Blue;
        }
    }
}
