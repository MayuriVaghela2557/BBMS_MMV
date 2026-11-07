using System;
using System.Web.UI.WebControls;

namespace LifeFlow
{
    public partial class AdminContacts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void btnFilterContacts_Click(object sender, EventArgs e)
        {
            // Backend code to be implemented by user
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Backend code to be implemented by user
        }
    }
}
