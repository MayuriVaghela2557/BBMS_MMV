<%@ Page Title="My Donations" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="MyDonations.aspx.cs" Inherits="LifeFlow.MyDonations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .donation-cert-pill {
            background: #fff1f2;
            color: #e11d48;
            border: 1px solid #fecdd3;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .donation-cert-pill:hover { background: #ffe4e6; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-heart-pulse" style="color:#e11d48;"></i> My Donation History</h3>
        <a href="DonationAppointment.aspx" class="btn-primary-custom">
            <i class="fa-solid fa-plus"></i> Schedule Donation
        </a>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by Center, Hospital or City..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Verified">Verified</asp:ListItem>
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- GridView Table -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Donation ID">
                        <ItemTemplate><asp:Label ID="lblDonId" runat="server" Text='<%# "#DON-" + Eval("DonationId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Bank / Camp Venue">
                        <ItemTemplate>
                            <strong><%# Eval("CenterName") %></strong>
                            <div style="font-size:11px; color:#881337;"><%# Eval("City") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Donated">
                        <ItemTemplate><strong><%# Eval("UnitsDonated") %> Units</strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Donation Date">
                        <ItemTemplate><%# Convert.ToDateTime(Eval("DonationDate")).ToString("dd MMM yyyy") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Verification Status">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("Status").ToString() == "Verified" ? "badge-status-verified" : "badge-status-pending" %>'>
                                <i class='fa-solid <%# Eval("Status").ToString() == "Verified" ? "fa-circle-check" : "fa-clock" %>'></i>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnView" runat="server" CommandName="ViewCert" CommandArgument='<%# Eval("DonationId") %>' CssClass="btn-icon-action btn-view" ToolTip="View Certificate">
                                    <i class="fa-solid fa-certificate"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteRec" CommandArgument='<%# Eval("DonationId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Delete this record entry?');" ToolTip="Delete Record">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-heart-pulse"></i>
                        <p style="margin:0; font-weight:500;">No donation history found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
