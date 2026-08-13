<%@ Page Title="Donation Camps | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DonationCamp.aspx.cs" Inherits="LifeFlow.DonationCamp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Find a camp near you</span>
      <h1>Donation Camps</h1>
      <p>Community donation drives organized across the region — no appointment required, walk-ins welcome.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Donation Camp</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== UPCOMING CAMPS GRID ===================== -->
  <section class="camps-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">This month &amp; next</span>
        <h2>Upcoming Camps</h2>
        <p>Register ahead of time to skip the queue, or simply walk in on the day.</p>
      </div>
      <div class="camp-grid">
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCampMedia1" runat="server" ImageUrl="~/images/hero-banner.jpg" AlternateText="Riverside Community Camp" />
            <div class="camp-date-badge"><span class="d">14</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>Riverside Community Camp</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-user-group"></i> Organized by Riverside Volunteers</span>
              <span><i class="fa-solid fa-location-dot"></i> Riverside Community Hall</span>
              <span><i class="fa-solid fa-clock"></i> 9:00 AM – 3:00 PM</span>
            </div>
            <a href="DonateBlood.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCampMedia2" runat="server" ImageUrl="~/images/about-team.jpg" AlternateText="Downtown Corporate Drive" />
            <div class="camp-date-badge"><span class="d">21</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>Downtown Corporate Drive</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-user-group"></i> Organized by Meridian Corp Wellness</span>
              <span><i class="fa-solid fa-location-dot"></i> Meridian Business Tower</span>
              <span><i class="fa-solid fa-clock"></i> 10:00 AM – 4:00 PM</span>
            </div>
            <a href="DonateBlood.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCampMedia3" runat="server" ImageUrl="~/images/donation-camp.jpg" AlternateText="University Campus Camp" />
            <div class="camp-date-badge"><span class="d">29</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>University Campus Camp</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-user-group"></i> Organized by Student Health Council</span>
              <span><i class="fa-solid fa-location-dot"></i> Springfield State University</span>
              <span><i class="fa-solid fa-clock"></i> 8:30 AM – 2:30 PM</span>
            </div>
            <a href="DonateBlood.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== HOST A CAMP CTA ===================== -->
  <section class="cta-band">
    <div class="container cta-inner">
      <div>
        <h2>Want to host a camp?</h2>
        <p>Offices, universities, and community groups can partner with us to organize a donation drive.</p>
      </div>
      <div class="cta-actions">
        <asp:HyperLink ID="lnkHostCampContact" runat="server" NavigateUrl="~/Contact.aspx" CssClass="btn btn-light"><i class="fa-solid fa-handshake"></i> Partner With Us</asp:HyperLink>
      </div>
    </div>
  </section>
</asp:Content>
