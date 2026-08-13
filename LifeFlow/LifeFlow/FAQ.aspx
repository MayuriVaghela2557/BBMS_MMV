<%@ Page Title="FAQ | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="LifeFlow.FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Answers before you donate or request</span>
      <h1>Frequently Asked Questions</h1>
      <p>Common questions about donating, requesting, and the safety standards behind every unit of blood.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>FAQ</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== FAQ ACCORDION ===================== -->
  <section class="faq-section">
    <div class="container">
      <div class="faq-list">
        <div class="faq-item">
          <button type="button" class="faq-question"><span>Who can donate blood?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Most healthy adults aged 18 to 65, weighing at least 50kg, can donate. A quick health screening at the center will confirm your eligibility on the day.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>How often can I donate?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Whole blood donors can typically donate every 56 days. Platelet donors may be eligible to donate more frequently — our staff will advise you based on your last donation.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>Is blood donation safe?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Yes. All equipment is sterile and single-use, and every donation is supervised by licensed medical staff following strict safety protocols.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>How long does a donation take?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">The donation itself takes about 8 to 10 minutes, though the full visit including registration and a short rest period usually takes 30 to 45 minutes.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>What should I do before donating?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Eat a healthy meal, stay well hydrated, and get a good night's sleep before your appointment. Avoid fatty foods right before donating.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>Can I request blood for a family member?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Yes. Use the Request Blood form with the patient's details, hospital, and required blood group, and mark the emergency level so our team can prioritize accordingly.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>Will donating blood make me weak?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Most donors feel completely normal afterward. We recommend resting for a few minutes, having a snack, and avoiding strenuous activity for the rest of the day.</div></div>
        </div>
        <div class="faq-item">
          <button type="button" class="faq-question"><span>How is my blood type determined?</span><i class="fa-solid fa-plus"></i></button>
          <div class="faq-answer"><div class="faq-answer-inner">Every donation is tested in our laboratory to confirm blood type and screen for safety before it's added to the available inventory.</div></div>
        </div>
      </div>

      <div class="text-center mt-40">
        <p style="color:var(--color-muted); margin-bottom:16px;">Still have a question?</p>
        <asp:HyperLink ID="lnkFaqContact" runat="server" NavigateUrl="~/Contact.aspx" CssClass="btn btn-primary"><i class="fa-solid fa-comments"></i> Contact Our Team</asp:HyperLink>
      </div>
    </div>
  </section>
</asp:Content>
