<%@ Page Title="Donation Camps" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonorCamps.aspx.cs" Inherits="LifeFlow.DonorCamps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .camp-venue-box strong { display: block; font-size: 13.5px; color: #4c0519; }
        .camp-venue-box span { font-size: 11px; color: #881337; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-tent" style="color:#e11d48;"></i> Upcoming Blood Donation Camps</h3>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by camp title, venue, organizer or city..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlCity" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Cities</asp:ListItem>
            <asp:ListItem Value="Ahmedabad">Ahmedabad</asp:ListItem>
            <asp:ListItem Value="Gandhinagar">Gandhinagar</asp:ListItem>
            <asp:ListItem Value="Surat">Surat</asp:ListItem>
            <asp:ListItem Value="Vadodara">Vadodara</asp:ListItem>
            <asp:ListItem Value="Rajkot">Rajkot</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Camps GridView -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Camp ID">
                        <ItemTemplate><asp:Label ID="lblCampId" runat="server" Text='<%# "#CMP-" + Eval("CampId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Camp Details & Organizer">
                        <ItemTemplate>
                            <div class="camp-venue-box">
                                <strong><%# Eval("CampTitle") %></strong>
                                <span>Organized by: <%# Eval("Organizer") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date & Timings">
                        <ItemTemplate>
                            <div><i class="fa-solid fa-calendar" style="color:#e11d48; font-size:11px;"></i> <%# Convert.ToDateTime(Eval("CampDate")).ToString("dd MMM yyyy") %></div>
                            <div style="font-size:11px; color:#881337;"><i class="fa-solid fa-clock" style="font-size:10px;"></i> <%# Eval("Timing") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Venue / Location">
                        <ItemTemplate><%# Eval("Venue") %>, <%# Eval("City") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Target Units">
                        <ItemTemplate><strong><%# Eval("TargetUnits") %> Units</strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate><span class="badge-pill badge-status-active"><%# Eval("Status") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Participate" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnJoin" runat="server" CommandName="RegisterCamp" CommandArgument='<%# Eval("CampId") %>' CssClass="btn-primary-custom" Style="padding:6px 12px; font-size:12px;">
                                <i class="fa-solid fa-hand-holding-heart"></i> Register
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-tent"></i>
                        <p style="margin:0; font-weight:500;">No active donation camps found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
