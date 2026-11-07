<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HospitalRegister.aspx.cs" Inherits="HospitalRegister" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Registration</title>
    <link rel="stylesheet" type="text/css" href="hospital.css" />
</head>
<body class="hospital-page">
    <h2>Hospital Registration</h2>
    <asp:Panel ID="pnlRegister" runat="server" CssClass="register-panel">
        <asp:Label ID="lblName" runat="server" Text="Hospital Name:" AssociatedControlID="txtName" /><br />
        <asp:TextBox ID="txtName" runat="server" CssClass="input" /><br />
        <asp:Label ID="lblAddress" runat="server" Text="Address:" AssociatedControlID="txtAddress" /><br />
        <asp:TextBox ID="txtAddress" runat="server" CssClass="input" TextMode="MultiLine" Rows="3" /><br />
        <asp:Label ID="lblContact" runat="server" Text="Contact Number:" AssociatedControlID="txtContact" /><br />
        <asp:TextBox ID="txtContact" runat="server" CssClass="input" /> <br />
        <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" /><br />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" /> <br />
        <asp:Label ID="lblUsername" runat="server" Text="Username:" AssociatedControlID="txtUsername" /><br />
        <asp:TextBox ID="txtUsername" runat="server" CssClass="input" /> <br />
        <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword" /><br />
        <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" /> <br /><br />
        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn" />
    </asp:Panel>
</body>
</html>
