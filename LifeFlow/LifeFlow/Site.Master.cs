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

        public string GetActiveClass(string pageName)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
            if (string.IsNullOrEmpty(currentPage) && pageName.Equals("Home.aspx", StringComparison.OrdinalIgnoreCase))
            {
                return "active";
            }
            return string.Equals(currentPage, pageName, StringComparison.OrdinalIgnoreCase) ? "active" : "";
        }
    }
}
