<%@ Page Title="Home | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LifeFlow.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== HERO SECTION ===================== -->
  <section class="hero">
    <div class="container hero-grid">
      <div class="hero-copy">
        <span class="eyebrow">Every drop counts</span>
        <h1>Donate Blood,<br>Save <span>Lives</span></h1>
        <p>Every donation can save multiple lives. Join a network of donors, hospitals, and volunteers keeping the region's blood supply steady, safe, and ready for the moment it's needed.</p>
        <div class="hero-actions">
          <asp:HyperLink ID="lnkHeroDonate" runat="server" NavigateUrl="~/DonateBlood.aspx" CssClass="btn btn-primary"><i class="fa-solid fa-droplet"></i> Donate Now</asp:HyperLink>
          <asp:HyperLink ID="lnkHeroRequest" runat="server" NavigateUrl="~/RequestBlood.aspx" CssClass="btn btn-ghost-light"><i class="fa-solid fa-hand-holding-medical"></i> Request Blood</asp:HyperLink>
        </div>
        <div class="hero-mini-stats">
          <div><strong data-counter="12480">12,480</strong><span>Registered Donors</span></div>
          <div><strong data-counter="860">860</strong><span>Hospital Partners</span></div>
          <div><strong data-counter="34200">34,200</strong><span>Lives Saved</span></div>
        </div>
      </div>
      <div class="hero-visual">
        <div class="hero-photo-card">
          <asp:Image ID="imgHero" runat="server" ImageUrl="~/images/hero-banner.jpg" AlternateText="Blood donor giving blood at a LifeLine donation center" />
          <div class="hero-photo-badge">
            <i class="fa-solid fa-heart-pulse"></i>
            <div><strong>Live Donation</strong><span>Springfield Center, Today</span></div>
          </div>
        </div>
      </div>
    </div>
    <svg class="pulse-divider on-dark pulse-anim" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== STATISTICS SECTION ===================== -->
  <section class="stats-strip">
    <div class="container">
      <div class="stats-card">
        <div class="stat-item">
          <i class="fa-solid fa-user-group"></i>
          <span class="num" data-counter="12480">12,480</span>
          <span class="label">Total Donors</span>
        </div>
        <div class="stat-item">
          <i class="fa-solid fa-flask-vial"></i>
          <span class="num" data-counter="48950">48,950</span>
          <span class="label">Blood Units Collected</span>
        </div>
        <div class="stat-item">
          <i class="fa-solid fa-hospital"></i>
          <span class="num" data-counter="860">860</span>
          <span class="label">Partner Hospitals</span>
        </div>
        <div class="stat-item">
          <i class="fa-solid fa-heart-circle-check"></i>
          <span class="num" data-counter="34200">34,200</span>
          <span class="label">Lives Saved</span>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== BLOOD GROUPS SECTION ===================== -->
  <section class="bloodgroups-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Live inventory</span>
        <h2>Blood Availability by Group</h2>
        <p>A quick snapshot of current stock levels across our partner blood banks. Tap a group to see full hospital-wise availability.</p>
      </div>
      <div class="bloodgroup-grid">
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">A+</div><h4>A Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">A-</div><h4>A Negative</h4><p class="avail low">Stock: <strong>Low</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">B+</div><h4>B Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">B-</div><h4>B Negative</h4><p class="avail low">Stock: <strong>Low</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">AB+</div><h4>AB Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">AB-</div><h4>AB Negative</h4><p class="avail low">Stock: <strong>Critical</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">O+</div><h4>O Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
        <a href="BloodAvailability.aspx" class="bg-card"><div class="bg-icon">O-</div><h4>O Negative</h4><p class="avail low">Stock: <strong>Critical</strong></p><span class="btn btn-outline btn-sm btn-block">View</span></a>
      </div>
    </div>
  </section>

  <!-- ===================== WHY DONATE BLOOD SECTION ===================== -->
  <section class="why-donate-section bg-tint">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">The impact</span>
        <h2>Why Donate Blood</h2>
        <p>Donating blood is one of the simplest acts with the biggest ripple effect — for patients, for hospitals, and for your own health.</p>
      </div>
      <div class="value-grid">
        <div class="value-card">
          <div class="value-icon"><i class="fa-solid fa-heart-circle-check"></i></div>
          <h3>Save Lives</h3>
          <p>A single donation can be separated into red cells, platelets, and plasma — helping up to three patients at once.</p>
        </div>
        <div class="value-card">
          <div class="value-icon"><i class="fa-solid fa-shield-heart"></i></div>
          <h3>Safe Process</h3>
          <p>Every donation follows strict sterile, single-use equipment protocols supervised by licensed medical staff.</p>
        </div>
        <div class="value-card">
          <div class="value-icon"><i class="fa-solid fa-stethoscope"></i></div>
          <h3>Health Benefits</h3>
          <p>Donors receive a free mini health screening and studies link regular donation to better iron regulation.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== HOW IT WORKS SECTION ===================== -->
  <section class="process-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">The journey of a donation</span>
        <h2>How It Works</h2>
        <p>From sign-up to a patient's bedside, here's the path every donation travels.</p>
      </div>
      <div class="process-track">
        <div class="process-step">
          <div class="process-connector"></div>
          <div class="process-node"><i class="fa-solid fa-user-plus"></i></div>
          <h4>Register</h4>
          <p>Sign up online or at a camp</p>
        </div>
        <div class="process-step">
          <div class="process-connector"></div>
          <div class="process-node"><i class="fa-solid fa-droplet"></i></div>
          <h4>Donate</h4>
          <p>A quick, guided donation</p>
        </div>
        <div class="process-step">
          <div class="process-connector"></div>
          <div class="process-node"><i class="fa-solid fa-vial-circle-check"></i></div>
          <h4>Testing</h4>
          <p>Screened for safety &amp; type</p>
        </div>
        <div class="process-step">
          <div class="process-connector"></div>
          <div class="process-node"><i class="fa-solid fa-warehouse"></i></div>
          <h4>Storage</h4>
          <p>Cold-chain storage on-site</p>
        </div>
        <div class="process-step is-final">
          <div class="process-node"><i class="fa-solid fa-hand-holding-heart"></i></div>
          <h4>Patient</h4>
          <p>Delivered where it's needed</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== DONATION CAMPS SECTION ===================== -->
  <section class="camps-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Get involved nearby</span>
        <h2>Upcoming Donation Camps</h2>
        <p>Can't make it to a center? Find a community camp close to you.</p>
      </div>
      <div class="camp-grid">
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCamp1" runat="server" ImageUrl="~/images/donation-camp.jpg" AlternateText="Riverside Community donation camp" />
            <div class="camp-date-badge"><span class="d">14</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>Riverside Community Camp</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-location-dot"></i> Riverside Community Hall</span>
              <span><i class="fa-solid fa-clock"></i> 9:00 AM – 3:00 PM</span>
            </div>
            <a href="DonationCamp.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCamp2" runat="server" ImageUrl="~/images/gallery-donation.jpg" AlternateText="Downtown Corporate donation drive" />
            <div class="camp-date-badge"><span class="d">21</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>Downtown Corporate Drive</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-location-dot"></i> Meridian Business Tower</span>
              <span><i class="fa-solid fa-clock"></i> 10:00 AM – 4:00 PM</span>
            </div>
            <a href="DonationCamp.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
        <div class="camp-card">
          <div class="camp-media">
            <asp:Image ID="imgCamp3" runat="server" ImageUrl="~/images/about-team.jpg" AlternateText="University Campus donation camp" />
            <div class="camp-date-badge"><span class="d">29</span><span class="m">Aug</span></div>
          </div>
          <div class="camp-body">
            <h3>University Campus Camp</h3>
            <div class="camp-meta">
              <span><i class="fa-solid fa-location-dot"></i> Springfield State University</span>
              <span><i class="fa-solid fa-clock"></i> 8:30 AM – 2:30 PM</span>
            </div>
            <a href="DonationCamp.aspx" class="btn btn-outline btn-sm btn-block">Register</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== CALL TO ACTION SECTION ===================== -->
  <section class="cta-band">
    <div class="container cta-inner">
      <div>
        <h2>Become a Blood Donor Today</h2>
        <p>Registration takes less than five minutes. Your next donation could be someone's second chance.</p>
      </div>
      <div class="cta-actions">
        <asp:HyperLink ID="lnkCtaRegister" runat="server" NavigateUrl="~/Register.aspx" CssClass="btn btn-light"><i class="fa-solid fa-user-plus"></i> Register as Donor</asp:HyperLink>
        <asp:HyperLink ID="lnkCtaDonate" runat="server" NavigateUrl="~/DonateBlood.aspx" CssClass="btn btn-ghost-light"><i class="fa-solid fa-droplet"></i> Donate Blood</asp:HyperLink>
      </div>
    </div>
  </section>
</asp:Content>
