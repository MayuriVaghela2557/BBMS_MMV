<%@ Page Title="Request Blood | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RequestBlood.aspx.cs" Inherits="LifeFlow.RequestBlood" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">We're here to help</span>
      <h1>Request Blood</h1>
      <p>Submit a request for a patient in need. Our coordination team prioritizes emergency cases immediately.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Request Blood</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== REQUEST FORM ===================== -->
  <section class="request-form-section">
    <div class="container">
      <div class="form-shell">
        <div class="form-shell-head">
          <i class="fa-solid fa-hand-holding-medical"></i>
          <h2>Blood Request Form</h2>
          <p>Complete all required fields below to submit an emergency blood request.</p>
        </div>

        <asp:ValidationSummary ID="vsRequest" runat="server" ValidationGroup="vgRequest" CssClass="alert alert-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
        <asp:Label ID="lblRequestMessage" runat="server" CssClass="form-message"></asp:Label>

        <div class="form-grid">
          <div class="form-group">
            <label for="<%= txtPatientName.ClientID %>">Patient Name <span class="req">*</span></label>
            <asp:TextBox ID="txtPatientName" runat="server" Placeholder="Enter patient name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvPatientName" runat="server" ControlToValidate="txtPatientName" ErrorMessage="Patient Name is required" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtHospital.ClientID %>">Hospital <span class="req">*</span></label>
            <asp:TextBox ID="txtHospital" runat="server" Placeholder="Enter hospital name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvHospital" runat="server" ControlToValidate="txtHospital" ErrorMessage="Hospital is required" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= ddlReqBloodGroup.ClientID %>">Blood Group <span class="req">*</span></label>
            <asp:DropDownList ID="ddlReqBloodGroup" runat="server" CssClass="form-control">
              <asp:ListItem Value="">Select blood group</asp:ListItem>
              <asp:ListItem Value="A+">A+</asp:ListItem>
              <asp:ListItem Value="A-">A-</asp:ListItem>
              <asp:ListItem Value="B+">B+</asp:ListItem>
              <asp:ListItem Value="B-">B-</asp:ListItem>
              <asp:ListItem Value="AB+">AB+</asp:ListItem>
              <asp:ListItem Value="AB-">AB-</asp:ListItem>
              <asp:ListItem Value="O+">O+</asp:ListItem>
              <asp:ListItem Value="O-">O-</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvReqBloodGroup" runat="server" ControlToValidate="ddlReqBloodGroup" InitialValue="" ErrorMessage="Blood Group is required" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtUnits.ClientID %>">Units Required <span class="req">*</span></label>
            <asp:TextBox ID="txtUnits" runat="server" TextMode="Number" Placeholder="e.g. 2" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvUnits" runat="server" ControlToValidate="txtUnits" ErrorMessage="Units required is required" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
            <asp:RangeValidator ID="rvUnits" runat="server" ControlToValidate="txtUnits" MinimumValue="1" MaximumValue="10" Type="Integer" ErrorMessage="Units required must be between 1 and 10" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group full">
            <label>Emergency Level <span class="req">*</span></label>
            <asp:RadioButtonList ID="rblEmergency" runat="server" RepeatDirection="Horizontal" CssClass="emergency-radio-list">
              <asp:ListItem Value="Normal" Selected="True">Normal</asp:ListItem>
              <asp:ListItem Value="Urgent">Urgent</asp:ListItem>
              <asp:ListItem Value="Critical">Critical</asp:ListItem>
            </asp:RadioButtonList>
          </div>

          <div class="form-group">
            <label for="<%= txtReqPhone.ClientID %>">Phone Number <span class="req">*</span></label>
            <asp:TextBox ID="txtReqPhone" runat="server" Placeholder="+1 (555) 000-0000" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvReqPhone" runat="server" ControlToValidate="txtReqPhone" ErrorMessage="Phone number is required" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revReqPhone" runat="server" ControlToValidate="txtReqPhone" ValidationExpression="^\+?[0-9\s\-\(\)]{7,20}$" ErrorMessage="Invalid phone number format" ValidationGroup="vgRequest" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtReqAddress.ClientID %>">Hospital Address</label>
            <asp:TextBox ID="txtReqAddress" runat="server" Placeholder="Hospital / ward address" CssClass="form-control" />
          </div>

          <div class="form-group full">
            <label for="<%= txtMessage.ClientID %>">Additional Details</label>
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" Placeholder="Any additional details for our coordination team" CssClass="form-control" />
          </div>
        </div>

        <div class="form-actions" style="margin-top:20px;">
          <asp:Button ID="btnRequestSubmit" runat="server" Text="Submit Blood Request" CssClass="btn btn-primary btn-block" ValidationGroup="vgRequest" OnClick="btnRequestSubmit_Click" />
          <p class="form-note"><i class="fa-solid fa-circle-info"></i> Backend functionality will be implemented in Phase 3.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== EMERGENCY NOTE ===================== -->
  <section class="cta-band">
    <div class="container cta-inner">
      <div>
        <h2>Need blood right now?</h2>
        <p>For critical, life-threatening emergencies, call our 24/7 hotline directly.</p>
      </div>
      <div class="cta-actions">
        <a href="tel:+18005551234" class="btn btn-light"><i class="fa-solid fa-phone"></i> +1 (800) 555-1234</a>
      </div>
    </div>
  </section>
</asp:Content>
