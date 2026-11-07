using System;

namespace LifeFlow
{
    public partial class AdminSiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                lblAdminName.Text = Session["admin"].ToString();
            }
            else
            {
                lblAdminName.Text = "Administrator";
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
