<%@ Page Title="Contact Us | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="LifeFlow.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">We'd love to hear from you</span>
      <h1>Contact Us</h1>
      <p>Questions, partnership ideas, or camp organizing — reach our team any time.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Contact</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== CONTACT INFO + FORM ===================== -->
  <section class="contact-section">
    <div class="container contact-grid">

      <div class="contact-info-card">
        <h3>Get in Touch</h3>
        <div class="contact-info-item">
          <i class="fa-solid fa-location-dot"></i>
          <div><strong>Address</strong><span>221 Meridian Avenue, Springfield, ST 62704</span></div>
        </div>
        <div class="contact-info-item">
          <i class="fa-solid fa-phone"></i>
          <div><strong>Phone</strong><a href="tel:+18005551234">+1 (800) 555-1234</a></div>
        </div>
        <div class="contact-info-item">
          <i class="fa-solid fa-envelope"></i>
          <div><strong>Email</strong><a href="mailto:help@lifelinebloodbank.org">help@lifelinebloodbank.org</a></div>
        </div>
        <div class="contact-info-item">
          <i class="fa-solid fa-clock"></i>
          <div><strong>Hours</strong><span>24/7 Emergency Response · Mon–Sat 8AM–6PM Walk-in</span></div>
        </div>
        <div class="contact-social">
          <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#" aria-label="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
          <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
        </div>
      </div>

      <div class="form-shell" style="box-shadow:var(--shadow-soft);">
        <div class="form-shell-head" style="text-align:left; margin-bottom:24px;">
          <h2>Send Us a Message</h2>
          <p>We typically respond within one business day.</p>
        </div>

        <asp:ValidationSummary ID="vsContact" runat="server" ValidationGroup="vgContact" CssClass="alert alert-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
        <asp:Label ID="lblContactMessage" runat="server" CssClass="form-message"></asp:Label>

        <div class="form-grid">
          <div class="form-group">
            <label for="<%= txtContactName.ClientID %>">Full Name <span class="req">*</span></label>
            <asp:TextBox ID="txtContactName" runat="server" Placeholder="Enter your name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName" ErrorMessage="Full Name is required" ValidationGroup="vgContact" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtContactEmail.ClientID %>">Email <span class="req">*</span></label>
            <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email" Placeholder="you@example.com" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvContactEmail" runat="server" ControlToValidate="txtContactEmail" ErrorMessage="Email is required" ValidationGroup="vgContact" Display="Dynamic" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revContactEmail" runat="server" ControlToValidate="txtContactEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email address format" ValidationGroup="vgContact" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group full">
            <label for="<%= txtContactSubject.ClientID %>">Subject</label>
            <asp:TextBox ID="txtContactSubject" runat="server" Placeholder="What is this about?" CssClass="form-control" />
          </div>

          <div class="form-group full">
            <label for="<%= txtContactMessage.ClientID %>">Message <span class="req">*</span></label>
            <asp:TextBox ID="txtContactMessage" runat="server" TextMode="MultiLine" Rows="4" Placeholder="Write your message here" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvContactMessage" runat="server" ControlToValidate="txtContactMessage" ErrorMessage="Message is required" ValidationGroup="vgContact" Display="Dynamic" ForeColor="Red" />
          </div>
        </div>

        <div class="form-actions" style="margin-top:20px;">
          <asp:Button ID="btnContactSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary btn-block" ValidationGroup="vgContact" OnClick="btnContactSubmit_Click" />
          <p class="form-note"><i class="fa-solid fa-circle-info"></i> Backend functionality will be implemented in Phase 3.</p>
        </div>
      </div>

    </div>

    <div class="container">
      <div class="map-placeholder">
        <i class="fa-solid fa-map-location-dot"></i>
        <span>Google Map Placeholder — 221 Meridian Avenue, Springfield, ST</span>
      </div>
    </div>
  </section>
</asp:Content>
