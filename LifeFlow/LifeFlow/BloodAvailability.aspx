<%@ Page Title="Blood Availability" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="BloodAvailability.aspx.cs" Inherits="LifeFlow.BloodAvailability" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .avail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .avail-card {
            background: #fff;
            padding: 24px 20px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
            border-top: 4px solid #0d9488;
            transition: transform 0.2s ease;
        }
        .avail-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .avail-blood-badge {
            width: 64px; height: 64px; border-radius: 50%;
            background: #fee2e2; color: #dc2626;
            margin: 0 auto 14px auto;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; font-weight: 800;
            font-family: 'Poppins', sans-serif;
            box-shadow: 0 4px 12px rgba(220,38,38,0.15);
        }
        .avail-card .units-count { font-size: 30px; font-weight: 700; color: #134e4a; font-family: 'Poppins', sans-serif; margin: 0; }
        .avail-card .units-label { font-size: 13px; color: #64748b; margin: 4px 0 12px 0; }
        .avail-level { padding: 5px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-block; }
        .level-safe { background: #ccfbf1; color: #0f766e; }
        .level-medium { background: #fef3c7; color: #b45309; }
        .level-critical { background: #fee2e2; color: #dc2626; }

        .filter-row { display: flex; gap: 12px; align-items: center; margin-bottom: 20px; flex-wrap: wrap; }
        .summary-note { background: #f0fdfa; border: 1px solid #99f6e4; border-radius: 10px; padding: 14px 18px; margin-bottom: 22px; font-size: 13px; color: #134e4a; display: flex; align-items: center; gap: 10px; }
        .summary-note i { color: #0d9488; font-size: 18px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-droplet" style="color:#ef4444;"></i> Blood Availability</h3>
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh Data" CssClass="btn-secondary-custom" OnClick="btnRefresh_Click" />
    </div>

    <!-- Info Note -->
    <div class="summary-note">
        <i class="fa-solid fa-circle-info"></i>
        <span>Showing current blood availability in your hospital stock. Last updated: <strong><asp:Label ID="lblLastUpdated" runat="server" Text="—"></asp:Label></strong></span>
    </div>

    <!-- Blood Group Cards -->
    <div class="avail-grid">
        <asp:Repeater ID="rptBloodCards" runat="server">
            <ItemTemplate>
                <div class="avail-card">
                    <div class="avail-blood-badge"><%# Eval("BloodGroup") %></div>
                    <p class="units-count"><%# Eval("UnitsAvailable") %></p>
                    <p class="units-label">Units Available</p>
                    <span class='avail-level <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "level-safe" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "level-medium" : "level-critical" %>'>
                        <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "Sufficient" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "Moderate" : "Critical" %>
                    </span>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Filter for Table -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search blood group..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterLevel" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Levels</asp:ListItem>
            <asp:ListItem Value="Sufficient">Sufficient (50+ Units)</asp:ListItem>
            <asp:ListItem Value="Moderate">Moderate (20-49 Units)</asp:ListItem>
            <asp:ListItem Value="Critical">Critical (&lt;20 Units)</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Availability Table -->
    <div class="table-card">
        <div class="section-header">
            <h3 class="section-title"><i class="fa-solid fa-table" style="color:#0d9488;"></i> Detailed Availability Table</h3>
        </div>
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag" style="font-size:14px; padding:6px 14px;"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Available">
                        <ItemTemplate><strong style="font-size:16px; color:#134e4a;"><%# Eval("UnitsAvailable") %> Units</strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stock Level">
                        <ItemTemplate>
                            <span class='avail-level <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "level-safe" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "level-medium" : "level-critical" %>'>
                                <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "Sufficient" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "Moderate" : "Critical" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Donation Date">
                        <ItemTemplate><asp:Label ID="lblLastDonation" runat="server" Text='<%# Eval("LastDonationDate") != null ? Convert.ToDateTime(Eval("LastDonationDate")).ToString("dd MMM yyyy") : "—" %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Updated">
                        <ItemTemplate><asp:Label ID="lblUpdated" runat="server" Text='<%# Eval("LastUpdated") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-droplet"></i>
                        <p style="margin:0; font-weight:500;">No blood availability data found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
