using System;
using System.IO;
using System.Web.UI;

namespace LifeFlow
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public bool IsUserLoggedIn()
        {
            return Session["admin"] != null || Session["hospital"] != null || Session["donor"] != null || Session["user"] != null || Session["username"] != null;
        }

        public string GetLoggedInUserName()
        {
            if (Session["admin"] != null)
                return Session["admin"].ToString();
            if (Session["hospital"] != null)
                return Session["hospital"].ToString();
            if (Session["donor"] != null)
                return Session["donor"].ToString();
            if (Session["user"] != null)
                return Session["user"].ToString();
            if (Session["username"] != null)
                return Session["username"].ToString();
            return "User";
        }

        public bool IsAdminLoggedIn()
        {
            return Session["admin"] != null;
        }

        public bool IsHospitalLoggedIn()
        {
            return Session["hospital"] != null;
        }

        public bool IsDonorLoggedIn()
        {
            return Session["donor"] != null;
        }

        public string GetActiveClass(string pageName)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
            if (string.IsNullOrEmpty(currentPage) && pageName.Equals("Home.aspx", StringComparison.OrdinalIgnoreCase))
            {
                return "active";
            }
            return string.Equals(currentPage, pageName, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }

        protected void lnkSiteLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
    }
}
