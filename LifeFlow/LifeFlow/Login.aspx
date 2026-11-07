<%@ Page Title="Admin Login | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LifeFlow.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Welcome back</span>
      <h1>Login</h1>
      <p>Sign in to access the administrator control panel and manage system data.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Admin Login</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== LOGIN FORM ===================== -->
  <section class="auth-section">
    <div class="container">
      <div class="form-shell narrow">
        <div class="form-shell-head">
          <i class="fa-solid fa-user-shield"></i>
          <h2>Login</h2>
          <p>Sign in with your admin credentials below.</p>
        </div>

          <div class="form-group">
    <label>Select Role</label>

    <asp:DropDownList ID="ddlRole" runat="server"
        CssClass="form-control">

        <asp:ListItem Text="-- Select Role --" Value="" />
        <asp:ListItem Text="Admin" Value="Admin" />
        <asp:ListItem Text="Hospital" Value="Hospital" />
        <asp:ListItem Text="Donor" Value="Donor" />
       

    </asp:DropDownList>

    <asp:RequiredFieldValidator
        ID="rfvRole"
        runat="server"
        ControlToValidate="ddlRole"
        InitialValue=""
        ErrorMessage="Please select your role"
        ForeColor="Red"
        ValidationGroup="vgLogin" />
</div>

        <asp:ValidationSummary ID="vsLogin" runat="server" ValidationGroup="vgLogin" CssClass="alert alert-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
        <asp:Label ID="lblLoginMessage" runat="server" CssClass="form-message"></asp:Label>

        <div class="form-grid" style="grid-template-columns:1fr;">
          <div class="form-group">
            <label for="<%= txtLoginUsername.ClientID %>">Username <span class="req">*</span></label>
            <asp:TextBox ID="txtLoginUsername" runat="server" Placeholder="Enter your admin username" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvLoginUsername" runat="server" ControlToValidate="txtLoginUsername" ErrorMessage="Username is required" ValidationGroup="vgLogin" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtLoginPassword.ClientID %>">Password <span class="req">*</span></label>
            <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" Placeholder="Enter your password" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server" ControlToValidate="txtLoginPassword" ErrorMessage="Password is required" ValidationGroup="vgLogin" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <div class="checkbox-row" style="display:flex; justify-content:space-between; align-items:center;">
              <asp:CheckBox ID="chkRememberMe" runat="server" Text=" Remember me" />
              <asp:HyperLink ID="lnkForgotPassword" runat="server" NavigateUrl="#">Forgot Password?</asp:HyperLink>
            </div>
          </div>
        </div>

        <div class="form-actions" style="margin-top:20px;">
          <asp:Button ID="btnLoginSubmit" runat="server" Text="Login" CssClass="btn btn-primary btn-block" ValidationGroup="vgLogin" OnClick="btnLoginSubmit_Click" />
        </div>
      </div>
    </div>
  </section>
</asp:Content>
