<%@ Page Title="Donate Blood | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DonateBlood.aspx.cs" Inherits="LifeFlow.DonateBlood" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Give the gift of life</span>
      <h1>Donate Blood</h1>
      <p>Fill in your details below to register as a donor. Our team will reach out to confirm your nearest donation slot.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Donate Blood</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== DONATION FORM ===================== -->
  <section class="donate-form-section">
    <div class="container">
      <div class="form-shell">
        <div class="form-shell-head">
          <i class="fa-solid fa-droplet"></i>
          <h2>Donor Registration Form</h2>
          <p>Complete all required fields below to submit your donation request.</p>
        </div>

        <asp:ValidationSummary ID="vsDonate" runat="server" ValidationGroup="vgDonate" CssClass="alert alert-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
        <asp:Label ID="lblDonateMessage" runat="server" CssClass="form-message"></asp:Label>

        <div class="form-grid">
          <div class="form-group">
            <label for="<%= txtFirstName.ClientID %>">First Name <span class="req">*</span></label>
            <asp:TextBox ID="txtFirstName" runat="server" Placeholder="Enter first name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtLastName.ClientID %>">Last Name <span class="req">*</span></label>
            <asp:TextBox ID="txtLastName" runat="server" Placeholder="Enter last name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= ddlGender.ClientID %>">Gender <span class="req">*</span></label>
            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control" ValidationGroup="vgDonate">
              <asp:ListItem Value="">Select gender</asp:ListItem>
              <asp:ListItem Value="Male">Male</asp:ListItem>
              <asp:ListItem Value="Female">Female</asp:ListItem>
              <asp:ListItem Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="ddlGender" InitialValue="" ErrorMessage="Gender is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtAge.ClientID %>">Age <span class="req">*</span></label>
            <asp:TextBox ID="txtAge" runat="server" TextMode="Number" Placeholder="18 - 65" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvAge" runat="server" ControlToValidate="txtAge" ErrorMessage="Age is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
            <asp:RangeValidator ID="rvAge" runat="server" ControlToValidate="txtAge" MinimumValue="18" MaximumValue="65" Type="Integer" ErrorMessage="Age must be between 18 and 65" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= ddlBloodGroup.ClientID %>">Blood Group <span class="req">*</span></label>
            <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="form-control">
              <asp:ListItem Value="">Select blood group</asp:ListItem>
              <asp:ListItem Value="A+">A+</asp:ListItem>
              <asp:ListItem Value="A-">A-</asp:ListItem>
              <asp:ListItem Value="B+">B+</asp:ListItem>
              <asp:ListItem Value="B-">B-</asp:ListItem>
              <asp:ListItem Value="AB+">AB+</asp:ListItem>
              <asp:ListItem Value="AB-">AB-</asp:ListItem>
              <asp:ListItem Value="O+">O+</asp:ListItem>
              <asp:ListItem Value="O-">O-</asp:ListItem>
              <asp:ListItem Value="Not sure">Not sure</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvBloodGroup" runat="server" ControlToValidate="ddlBloodGroup" InitialValue="" ErrorMessage="Blood Group is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtWeight.ClientID %>">Weight (kg) <span class="req">*</span></label>
            <asp:TextBox ID="txtWeight" runat="server" TextMode="Number" Placeholder="Minimum 50kg" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvWeight" runat="server" ControlToValidate="txtWeight" ErrorMessage="Weight is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
            <asp:RangeValidator ID="rvWeight" runat="server" ControlToValidate="txtWeight" MinimumValue="50" MaximumValue="200" Type="Integer" ErrorMessage="Weight must be at least 50 kg" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtPhone.ClientID %>">Phone Number <span class="req">*</span></label>
            <asp:TextBox ID="txtPhone" runat="server" Placeholder="+1 (555) 000-0000" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ValidationExpression="^\+?[0-9\s\-\(\)]{7,20}$" ErrorMessage="Invalid phone number format" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtEmail.ClientID %>">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="you@example.com" CssClass="form-control" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email address" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group full">
            <label for="<%= txtAddress.ClientID %>">Address <span class="req">*</span></label>
            <asp:TextBox ID="txtAddress" runat="server" Placeholder="Street address" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtCity.ClientID %>">City <span class="req">*</span></label>
            <asp:TextBox ID="txtCity" runat="server" Placeholder="Enter city" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtState.ClientID %>">State <span class="req">*</span></label>
            <asp:TextBox ID="txtState" runat="server" Placeholder="Enter state" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" ErrorMessage="State is required" ValidationGroup="vgDonate" Display="Dynamic" ForeColor="Red" />
          </div>
        </div>

        <div class="form-actions" style="margin-top: 20px;">
          <asp:Button ID="btnDonateSubmit" runat="server" Text="Submit Donor Registration" CssClass="btn btn-primary btn-block" ValidationGroup="vgDonate" OnClick="btnDonateSubmit_Click" />
          <p class="form-note"><i class="fa-solid fa-circle-info"></i> Backend functionality will be implemented in Phase 3.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== ELIGIBILITY QUICK NOTE ===================== -->
  <section class="choose-section bg-tint">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Before you donate</span>
        <h2>Basic Eligibility</h2>
      </div>
      <div class="choose-grid">
        <div class="choose-card"><i class="fa-solid fa-cake-candles"></i><h4>Age 18–65</h4><p>Most healthy adults qualify.</p></div>
        <div class="choose-card"><i class="fa-solid fa-weight-scale"></i><h4>50kg+ Weight</h4><p>Minimum weight for a safe donation.</p></div>
        <div class="choose-card"><i class="fa-solid fa-calendar-check"></i><h4>56-Day Gap</h4><p>Wait between whole-blood donations.</p></div>
        <div class="choose-card"><i class="fa-solid fa-heart-pulse"></i><h4>Good Health</h4><p>No active illness on the day of donation.</p></div>
      </div>
    </div>
  </section>
</asp:Content>
