<%@ Page Title="Gallery | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="LifeFlow.Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Moments worth sharing</span>
      <h1>Gallery</h1>
      <p>A look at our hospitals, camps, medical teams, and the donation moments that keep the network running.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Gallery</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== GALLERY GRID ===================== -->
  <section class="gallery-section">
    <div class="container">
      <div class="filter-tabs">
        <button type="button" class="is-active" data-filter="all">All</button>
        <button type="button" class="" data-filter="hospital">Hospitals</button>
        <button type="button" class="" data-filter="camp">Donation Camps</button>
        <button type="button" class="" data-filter="doctors">Doctors</button>
        <button type="button" class="" data-filter="patients">Patients</button>
        <button type="button" class="" data-filter="donation">Blood Donation</button>
      </div>
      <div class="gallery-grid">
        <div class="gallery-item" data-category="hospital" data-caption="Springfield General — Reception Wing" data-photo="images/hero-banner.jpg">
          <asp:Image ID="imgGal1" runat="server" ImageUrl="~/images/hero-banner.jpg" AlternateText="Springfield General — Reception Wing" />
          <div class="gal-caption">Springfield General — Reception Wing</div>
        </div>
        <div class="gallery-item" data-category="camp" data-caption="Riverside Community Donation Camp" data-photo="images/about-team.jpg">
          <asp:Image ID="imgGal2" runat="server" ImageUrl="~/images/about-team.jpg" AlternateText="Riverside Community Donation Camp" />
          <div class="gal-caption">Riverside Community Donation Camp</div>
        </div>
        <div class="gallery-item" data-category="doctors" data-caption="Screening with Dr. Elena Ward" data-photo="images/donation-camp.jpg">
          <asp:Image ID="imgGal3" runat="server" ImageUrl="~/images/donation-camp.jpg" AlternateText="Screening with Dr. Elena Ward" />
          <div class="gal-caption">Screening with Dr. Elena Ward</div>
        </div>
        <div class="gallery-item" data-category="donation" data-caption="Donation in Progress" data-photo="images/gallery-donation.jpg">
          <asp:Image ID="imgGal4" runat="server" ImageUrl="~/images/gallery-donation.jpg" AlternateText="Donation in Progress" />
          <div class="gal-caption">Donation in Progress</div>
        </div>
        <div class="gallery-item" data-category="patients" data-caption="Patient Recovery Ward" data-photo="images/hero-banner.jpg">
          <asp:Image ID="imgGal5" runat="server" ImageUrl="~/images/hero-banner.jpg" AlternateText="Patient Recovery Ward" />
          <div class="gal-caption">Patient Recovery Ward</div>
        </div>
        <div class="gallery-item" data-category="camp" data-caption="Downtown Corporate Drive" data-photo="images/about-team.jpg">
          <asp:Image ID="imgGal6" runat="server" ImageUrl="~/images/about-team.jpg" AlternateText="Downtown Corporate Drive" />
          <div class="gal-caption">Downtown Corporate Drive</div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== LIGHTBOX OVERLAY ===================== -->
  <div class="lightbox-overlay">
    <span class="lightbox-close"><i class="fa-solid fa-xmark"></i></span>
    <div class="lightbox-box">
      <div class="lightbox-media"><img src="images/hero-banner.jpg" alt="" /></div>
      <div class="lightbox-caption">
        <span class="lightbox-caption-text">Caption</span>
        <i class="fa-solid fa-droplet" style="color:var(--color-primary);"></i>
      </div>
    </div>
  </div>
</asp:Content>
