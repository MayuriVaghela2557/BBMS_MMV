<%@ Page Title="Hospital Dashboard" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="HospitalDashboard.aspx.cs" Inherits="LifeFlow.HospitalDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        .stat-card-item {
            background: #ffffff;
            padding: 20px 24px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-left: 4px solid #0d9488;
        }
        .stat-card-item:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .stat-info h4 { margin: 0 0 6px 0; font-size: 12px; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }
        .stat-info p { margin: 0; font-size: 28px; font-weight: 700; color: #134e4a; font-family: 'Poppins', sans-serif; }
        .stat-icon { width: 52px; height: 52px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px; }
        .icon-teal { background: #ccfbf1; color: #0d9488; }
        .icon-blue { background: #e0f2fe; color: #0284c7; }
        .icon-orange { background: #fef3c7; color: #d97706; }
        .icon-red { background: #fee2e2; color: #ef4444; }
        .icon-green { background: #dcfce7; color: #16a34a; }

        .quick-actions-bar {
            background: #ffffff;
            padding: 18px 24px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }
        .quick-actions-bar h4 { margin: 0; font-size: 16px; font-weight: 600; color: #134e4a; }
        .action-buttons-group { display: flex; gap: 12px; flex-wrap: wrap; }

        .dashboard-main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }
        @media (max-width: 992px) { .dashboard-main-grid { grid-template-columns: 1fr; } }

        .stock-bar-item { margin-bottom: 14px; }
        .stock-bar-label { display: flex; justify-content: space-between; font-size: 13px; font-weight: 600; margin-bottom: 5px; color: #134e4a; }
        .bar-bg { height: 10px; background: #f0fdfa; border-radius: 6px; overflow: hidden; }
        .bar-fill { height: 100%; border-radius: 6px; background: linear-gradient(90deg, #0d9488, #5eead4); transition: width 0.4s ease; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <!-- Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Total Blood Stock</h4>
                <p><asp:Label ID="lblTotalStock" runat="server" Text="0"></asp:Label> <small style="font-size:14px;">Units</small></p>
            </div>
            <div class="stat-icon icon-teal"><i class="fa-solid fa-boxes-stacked"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Pending Requests</h4>
                <p><asp:Label ID="lblPendingReq" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-orange"><i class="fa-solid fa-clock"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Approved Requests</h4>
                <p><asp:Label ID="lblApprovedReq" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-green"><i class="fa-solid fa-circle-check"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Total Donations</h4>
                <p><asp:Label ID="lblTotalDonations" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-red"><i class="fa-solid fa-heart-pulse"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Critical Stock Groups</h4>
                <p><asp:Label ID="lblCriticalStock" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-blue"><i class="fa-solid fa-triangle-exclamation"></i></div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions-bar">
        <h4><i class="fa-solid fa-bolt" style="color:#f59e0b;"></i> Quick Actions</h4>
        <div class="action-buttons-group">
            <a href="HospitalRequests.aspx" class="btn-primary-custom"><i class="fa-solid fa-plus"></i> New Blood Request</a>
            <a href="ManageBloodStock.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #0284c7, #0369a1);"><i class="fa-solid fa-boxes-stacked"></i> Update Stock</a>
            <a href="DonationRecords.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #16a34a, #15803d);"><i class="fa-solid fa-heart-pulse"></i> Add Donation</a>
        </div>
    </div>

    <!-- Main Grid -->
    <div class="dashboard-main-grid">
        <!-- Recent Requests -->
        <div class="table-card">
            <div class="section-header">
                <h3 class="section-title"><i class="fa-solid fa-list-check" style="color:#0d9488;"></i> Recent Blood Requests</h3>
                <a href="HospitalRequests.aspx" class="btn-secondary-custom" style="font-size:13px; padding:6px 14px;">View All</a>
            </div>
            <div class="table-responsive-wrapper">
                <asp:GridView ID="gvRecentRequests" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Req ID">
                            <ItemTemplate><asp:Label ID="lblReqId" runat="server" Text='<%# "#REQ-" + Eval("RequestId") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient Name">
                            <ItemTemplate><strong><%# Eval("PatientName") %></strong></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Blood Group">
                            <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Units">
                            <ItemTemplate><strong><%# Eval("UnitsNeeded") %></strong></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate><span class="badge-pill badge-status-pending"><%# Eval("Status") %></span></ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-placeholder">
                            <i class="fa-solid fa-inbox"></i>
                            <p>No recent blood requests.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

        <!-- Stock Summary -->
        <div class="table-card">
            <div class="section-header">
                <h3 class="section-title"><i class="fa-solid fa-droplet" style="color:#ef4444;"></i> Stock Status</h3>
                <a href="ManageBloodStock.aspx" class="btn-secondary-custom" style="font-size:13px; padding:6px 14px;">Manage</a>
            </div>
            <asp:Repeater ID="rptStockSummary" runat="server">
                <ItemTemplate>
                    <div class="stock-bar-item">
                        <div class="stock-bar-label">
                            <span><%# Eval("BloodGroup") %></span>
                            <span style="color:#64748b;"><%# Eval("UnitsAvailable") %> Units</span>
                        </div>
                        <div class="bar-bg">
                            <div class="bar-fill" style='width: <%# Math.Min(Convert.ToInt32(Eval("UnitsAvailable")), 100) %>%;'></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>
