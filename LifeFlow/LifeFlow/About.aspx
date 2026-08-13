<%@ Page Title="About Us | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="LifeFlow.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Who we are</span>
      <h1>About LifeLine Blood Bank</h1>
      <p>A community-driven network built to make sure blood is available exactly when and where it's needed.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>About</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== ORGANIZATION OVERVIEW ===================== -->
  <section class="about-overview">
    <div class="container split-block">
      <div class="split-media">
        <asp:Image ID="imgAboutTeam" runat="server" ImageUrl="~/images/about-team.jpg" AlternateText="LifeLine Blood Bank medical team" />
        <div class="float-card">
          <i class="fa-solid fa-award"></i>
          <div><strong>18 Years</strong><span>Serving the community</span></div>
        </div>
      </div>
      <div class="split-copy">
        <span class="eyebrow">Our story</span>
        <h2>Built by donors, run for patients</h2>
        <p>LifeLine Blood Bank began as a single collection center and has grown into a regional network linking donors, mobile camps, testing labs, and partner hospitals. Every process — from registration to delivery — is designed around one goal: no request should ever go unmet.</p>
        <p>Today we coordinate with hundreds of hospitals and thousands of donors to keep a steady, safe blood supply available around the clock.</p>
        <ul class="split-list">
          <li><i class="fa-solid fa-circle-check"></i> Licensed medical staff at every collection point</li>
          <li><i class="fa-solid fa-circle-check"></i> Rigorous screening and cold-chain storage standards</li>
          <li><i class="fa-solid fa-circle-check"></i> 24/7 emergency request coordination</li>
        </ul>
      </div>
    </div>
  </section>

  <!-- ===================== MISSION / VISION / OBJECTIVES ===================== -->
  <section class="mv-section bg-tint">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">What drives us</span>
        <h2>Mission, Vision &amp; Objectives</h2>
      </div>
      <div class="mv-grid">
        <div class="mv-card">
          <i class="fa-solid fa-bullseye"></i>
          <h3>Our Mission</h3>
          <p>To make safe blood accessible to every patient in need, by connecting willing donors with hospitals through a fast, transparent system.</p>
        </div>
        <div class="mv-card">
          <i class="fa-solid fa-eye"></i>
          <h3>Our Vision</h3>
          <p>A future where blood shortages never delay treatment, supported by an informed and engaged donor community.</p>
        </div>
        <div class="mv-card">
          <i class="fa-solid fa-list-check"></i>
          <h3>Our Objectives</h3>
          <p>Expand donor registration, maintain rigorous safety standards, and shorten response time between a request and a matched unit.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== OUR TEAM ===================== -->
  <section class="team-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">The people behind LifeLine</span>
        <h2>Our Team</h2>
        <p>A dedicated group of medical professionals and coordinators keeping every donation safe.</p>
      </div>
      <div class="team-grid">
        <div class="team-card">
          <div class="team-photo"><i class="fa-solid fa-user-doctor"></i></div>
          <div class="team-info"><h4>Dr. Elena Ward</h4><span>Medical Director</span></div>
        </div>
        <div class="team-card">
          <div class="team-photo"><i class="fa-solid fa-user-nurse"></i></div>
          <div class="team-info"><h4>James Okafor</h4><span>Head of Donor Relations</span></div>
        </div>
        <div class="team-card">
          <div class="team-photo"><i class="fa-solid fa-user-doctor"></i></div>
          <div class="team-info"><h4>Dr. Priya Nair</h4><span>Laboratory Lead</span></div>
        </div>
        <div class="team-card">
          <div class="team-photo"><i class="fa-solid fa-user-tie"></i></div>
          <div class="team-info"><h4>Marcus Webb</h4><span>Operations Manager</span></div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== WHY CHOOSE US ===================== -->
  <section class="choose-section bg-tint">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Why patients &amp; hospitals trust us</span>
        <h2>Why Choose Us</h2>
      </div>
      <div class="choose-grid">
        <div class="choose-card"><i class="fa-solid fa-bolt"></i><h4>Rapid Response</h4><p>Emergency requests matched within minutes.</p></div>
        <div class="choose-card"><i class="fa-solid fa-shield-heart"></i><h4>Verified Safety</h4><p>Every unit tested to national health standards.</p></div>
        <div class="choose-card"><i class="fa-solid fa-map-location-dot"></i><h4>Wide Network</h4><p>Hundreds of partner hospitals across the region.</p></div>
        <div class="choose-card"><i class="fa-solid fa-headset"></i><h4>24/7 Support</h4><p>A coordination team always on call.</p></div>
      </div>
    </div>
  </section>

  <!-- ===================== CALL TO ACTION ===================== -->
  <section class="cta-band">
    <div class="container cta-inner">
      <div>
        <h2>Want to be part of the story?</h2>
        <p>Register as a donor and help us keep the promise to every patient.</p>
      </div>
      <div class="cta-actions">
        <asp:HyperLink ID="lnkAboutRegister" runat="server" NavigateUrl="~/Register.aspx" CssClass="btn btn-light"><i class="fa-solid fa-user-plus"></i> Register as Donor</asp:HyperLink>
      </div>
    </div>
  </section>
</asp:Content>
