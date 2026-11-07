using System;
using System.Drawing;
using System.Web.UI;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;



namespace LifeFlow
{
    public partial class Contact : Page
    {

        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
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
