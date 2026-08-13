namespace LifeFlow
{
    public partial class RequestBlood
    {
        protected global::System.Web.UI.WebControls.Label lblRequestMessage;
        protected global::System.Web.UI.WebControls.ValidationSummary vsRequest;
        protected global::System.Web.UI.WebControls.TextBox txtPatientName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPatientName;
        protected global::System.Web.UI.WebControls.DropDownList ddlBloodGroup;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvBloodGroup;
        protected global::System.Web.UI.WebControls.TextBox txtHospitalName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvHospitalName;
        protected global::System.Web.UI.WebControls.TextBox txtUnitsRequired;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvUnitsRequired;
        protected global::System.Web.UI.WebControls.RangeValidator rvUnitsRequired;
        protected global::System.Web.UI.WebControls.TextBox txtContactPerson;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvContactPerson;
        protected global::System.Web.UI.WebControls.TextBox txtContactNumber;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvContactNumber;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revContactNumber;
        protected global::System.Web.UI.WebControls.Button btnRequestSubmit;
    }
}
