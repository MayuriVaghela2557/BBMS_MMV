<%@ Page Title="Hospital Reports" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="HospitalReports.aspx.cs" Inherits="LifeFlow.HospitalReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .report-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ccfbf1;
            padding-bottom: 2px;
        }
        .report-tab-btn {
            background: none;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 600;
            color: #64748b;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-family: inherit;
        }
        .report-tab-btn:hover {
            color: #0d9488;
        }
        .report-tab-btn.active {
            color: #0d9488;
            border-bottom-color: #0d9488;
        }
        .report-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 25px;
        }
        .report-stat-box {
            background: #ffffff;
            padding: 18px 22px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border-left: 4px solid #0d9488;
        }
        .report-stat-box h5 {
            margin: 0 0 6px 0;
            font-size: 12px;
            color: #64748b;
            text-transform: uppercase;
            font-weight: 600;
        }
        .report-stat-box h3 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            color: #134e4a;
            font-family: 'Poppins', sans-serif;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-chart-bar" style="color:#0d9488;"></i> Hospital Activity & Stock Reports</h3>
        <button type="button" class="btn-primary-custom" onclick="window.print();">
            <i class="fa-solid fa-print"></i> Print Report
        </button>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Top Report Summary -->
    <div class="report-stats-grid">
        <div class="report-stat-box">
            <h5>Total Stock Updates</h5>
            <h3><asp:Label ID="lblTotalStockLogs" runat="server" Text="0"></asp:Label></h3>
        </div>
        <div class="report-stat-box" style="border-left-color: #0284c7;">
            <h5>Verified Donations</h5>
            <h3><asp:Label ID="lblTotalDonationsCount" runat="server" Text="0"></asp:Label></h3>
        </div>
        <div class="report-stat-box" style="border-left-color: #16a34a;">
            <h5>Fulfilled Requests</h5>
            <h3><asp:Label ID="lblFulfilledRequestsCount" runat="server" Text="0"></asp:Label></h3>
        </div>
        <div class="report-stat-box" style="border-left-color: #f59e0b;">
            <h5>Total Units Handled</h5>
            <h3><asp:Label ID="lblTotalUnitsHandled" runat="server" Text="0 Units"></asp:Label></h3>
        </div>
    </div>

    <!-- Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search report by details, blood group, donor..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
            <asp:ListItem Value="All">All Operations</asp:ListItem>
            <asp:ListItem Value="Stock">Stock Changes</asp:ListItem>
            <asp:ListItem Value="Donation">Donation Records</asp:ListItem>
            <asp:ListItem Value="Fulfilled">Fulfilled Requests</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Generate" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Reports GridView -->
    <div class="table-card">
        <div class="section-header">
            <h3 class="section-title"><i class="fa-solid fa-file-lines" style="color:#0d9488;"></i> Operational Log & Records</h3>
        </div>
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Log ID">
                        <ItemTemplate><asp:Label ID="lblLogId" runat="server" Text='<%# "#LOG-" + Eval("LogId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Operation Type">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("OperationType").ToString() == "Stock Added" ? "badge-status-approved" : Eval("OperationType").ToString() == "Donation Verified" ? "badge-status-active" : "badge-urgency-normal" %>'>
                                <i class='fa-solid <%# Eval("OperationType").ToString() == "Stock Added" ? "fa-box-archive" : Eval("OperationType").ToString() == "Donation Verified" ? "fa-hand-holding-medical" : "fa-circle-check" %>'></i>
                                <%# Eval("OperationType") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units">
                        <ItemTemplate><strong><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("Units") + " Units" %>'></asp:Label></strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description / Details">
                        <ItemTemplate><asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Timestamp">
                        <ItemTemplate><asp:Label ID="lblTimestamp" runat="server" Text='<%# Convert.ToDateTime(Eval("Timestamp")).ToString("dd MMM yyyy, hh:mm tt") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Handled By">
                        <ItemTemplate><asp:Label ID="lblUser" runat="server" Text='<%# Eval("HandledBy") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnView" runat="server" CommandName="ViewLog" CommandArgument='<%# Eval("LogId") %>' CssClass="btn-icon-action btn-view" ToolTip="View Details">
                                    <i class="fa-solid fa-eye"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteLog" CommandArgument='<%# Eval("LogId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Delete this record entry?');" ToolTip="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-chart-bar"></i>
                        <p style="margin:0; font-weight:500;">No report logs found for selected criteria.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
