<%@ Page Title="Blood Availability | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BloodAvailability.aspx.cs" Inherits="LifeFlow.BloodAvailability" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Live inventory</span>
      <h1>Blood Availability</h1>
      <p>Check current blood stock across our partner hospitals.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Blood Availability</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== BLOOD GROUP QUICK FILTER ===================== -->
  <section class="bloodgroups-section">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Quick filter</span>
        <h2>Check by Blood Group</h2>
        <p>Select a group to filter hospital availability.</p>
      </div>
      <div class="bloodgroup-grid">
        <div class="bg-card"><div class="bg-icon">A+</div><h4>A Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">A-</div><h4>A Negative</h4><p class="avail low">Stock: <strong>Low</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">B+</div><h4>B Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">B-</div><h4>B Negative</h4><p class="avail low">Stock: <strong>Low</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">AB+</div><h4>AB Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">AB-</div><h4>AB Negative</h4><p class="avail low">Stock: <strong>Critical</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">O+</div><h4>O Positive</h4><p class="avail">Stock: <strong>Good</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
        <div class="bg-card"><div class="bg-icon">O-</div><h4>O Negative</h4><p class="avail low">Stock: <strong>Critical</strong></p><span class="btn btn-outline btn-sm btn-block">Filter Table</span></div>
      </div>
    </div>
  </section>

  <!-- ===================== SEARCH + TABLE ===================== -->
  <section class="availability-table-section bg-tint">
    <div class="container">
      <div class="section-head centered">
        <span class="eyebrow">Search by hospital or city</span>
        <h2>Hospital-wise Availability</h2>
      </div>

      <div class="search-bar-wrap">
        <asp:TextBox ID="txtAvailSearch" runat="server" Placeholder="Search by hospital or city..." CssClass="form-control" />
        <asp:DropDownList ID="availGroupSelect" runat="server" CssClass="form-control">
          <asp:ListItem Value="all">All Blood Groups</asp:ListItem>
          <asp:ListItem Value="A+">A+</asp:ListItem>
          <asp:ListItem Value="A-">A-</asp:ListItem>
          <asp:ListItem Value="B+">B+</asp:ListItem>
          <asp:ListItem Value="B-">B-</asp:ListItem>
          <asp:ListItem Value="AB+">AB+</asp:ListItem>
          <asp:ListItem Value="AB-">AB-</asp:ListItem>
          <asp:ListItem Value="O+">O+</asp:ListItem>
          <asp:ListItem Value="O-">O-</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
      </div>
      <asp:Label ID="lblSearchMessage" runat="server" CssClass="form-message" Style="display:block; margin: 15px 0; text-align:center;"></asp:Label>

      <div class="avail-table-wrap">
        <table class="avail-table">
          <thead>
            <tr>
              <th>Hospital Name</th>
              <th>City</th>
              <th>Blood Group</th>
              <th>Available Units</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>St. Mary's Hospital</td>
              <td>Springfield</td>
              <td>A+</td>
              <td>42 units</td>
              <td><span class="badge status-good">Good Stock</span></td>
            </tr>
            <tr>
              <td>Riverside Medical Center</td>
              <td>Springfield</td>
              <td>O-</td>
              <td>3 units</td>
              <td><span class="badge status-critical">Critical</span></td>
            </tr>
            <tr>
              <td>Springfield General Hospital</td>
              <td>Springfield</td>
              <td>B+</td>
              <td>27 units</td>
              <td><span class="badge status-good">Good Stock</span></td>
            </tr>
            <tr>
              <td>Meridian Health Institute</td>
              <td>Fairview</td>
              <td>AB-</td>
              <td>5 units</td>
              <td><span class="badge status-critical">Critical</span></td>
            </tr>
            <tr>
              <td>Fairview Community Hospital</td>
              <td>Fairview</td>
              <td>A-</td>
              <td>11 units</td>
              <td><span class="badge status-low">Low Stock</span></td>
            </tr>
            <tr>
              <td>St. Luke's Medical Center</td>
              <td>Oakdale</td>
              <td>O+</td>
              <td>58 units</td>
              <td><span class="badge status-good">Good Stock</span></td>
            </tr>
            <tr>
              <td>Oakdale Regional Hospital</td>
              <td>Oakdale</td>
              <td>B-</td>
              <td>9 units</td>
              <td><span class="badge status-low">Low Stock</span></td>
            </tr>
            <tr>
              <td>Northside Trauma Center</td>
              <td>Northside</td>
              <td>AB+</td>
              <td>19 units</td>
              <td><span class="badge status-good">Good Stock</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</asp:Content>
