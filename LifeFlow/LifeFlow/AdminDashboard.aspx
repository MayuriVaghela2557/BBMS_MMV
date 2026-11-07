<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="LifeFlow.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
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
        }
        .stat-card-item:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .stat-info h4 {
            margin: 0 0 6px 0;
            font-size: 13px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }
        .stat-info p {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            font-family: 'Poppins', sans-serif;
        }
        .stat-icon {
            width: 54px;
            height: 54px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .icon-red { background: #fee2e2; color: #ef4444; }
        .icon-blue { background: #e0f2fe; color: #0284c7; }
        .icon-green { background: #dcfce7; color: #16a085; }
        .icon-orange { background: #fef3c7; color: #d97706; }
        .icon-purple { background: #f3e8ff; color: #9333ea; }

        /* Quick Action Section */
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
        .quick-actions-bar h4 { margin: 0; font-size: 16px; font-weight: 600; color: #334155; }
        .action-buttons-group { display: flex; gap: 12px; flex-wrap: wrap; }

        /* Dashboard Grid Split */
        .dashboard-main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }
        @media (max-width: 992px) {
            .dashboard-main-grid { grid-template-columns: 1fr; }
        }

        .stock-progress-item {
            margin-bottom: 16px;
        }
        .stock-progress-label {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 6px;
        }
        .progress-bar-bg {
            height: 10px;
            background: #f1f5f9;
            border-radius: 6px;
            overflow: hidden;
        }
        .progress-bar-fill {
            height: 100%;
            border-radius: 6px;
            transition: width 0.4s ease;
        }
        .empty-placeholder {
            text-align: center;
            padding: 35px 20px;
            color: #94a3b8;
        }
        .empty-placeholder i {
            font-size: 36px;
            margin-bottom: 10px;
            color: #cbd5e1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
    
    <!-- Top Summary Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Total Donors</h4>
                <p><asp:Label ID="lblTotalDonors" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-red">
                <i class="fa-solid fa-hand-holding-droplet"></i>
            </div>
        </div>

        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Registered Users</h4>
                <p><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-blue">
                <i class="fa-solid fa-users"></i>
            </div>
        </div>

        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Hospitals</h4>
                <p><asp:Label ID="lblTotalHospitals" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-green">
                <i class="fa-solid fa-hospital"></i>
            </div>
        </div>

        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Pending Requests</h4>
                <p><asp:Label ID="lblPendingRequests" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-orange">
                <i class="fa-solid fa-clock"></i>
            </div>
        </div>

        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Total Stock</h4>
                <p><asp:Label ID="lblTotalStock" runat="server" Text="0 Units"></asp:Label></p>
            </div>
            <div class="stat-icon icon-purple">
                <i class="fa-solid fa-boxes-stacked"></i>
            </div>
        </div>
    </div>

    <!-- Quick Shortcuts Bar -->
    <div class="quick-actions-bar">
        <h4><i class="fa-solid fa-bolt text-warning"></i> Quick Management Actions</h4>
        <div class="action-buttons-group">
            <a href="AdminDonors.aspx" class="btn-primary-custom"><i class="fa-solid fa-plus"></i> Add New Donor</a>
            <a href="AdminHospitals.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #10b981, #059669);"><i class="fa-solid fa-plus"></i> Add Hospital</a>
            <a href="AdminBloodRequests.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #0ea5e9, #0284c7);"><i class="fa-solid fa-paper-plane"></i> New Request</a>
            <a href="AdminBloodStock.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);"><i class="fa-solid fa-box-archive"></i> Update Stock</a>
        </div>
    </div>

    <!-- Dashboard Main Grid -->
    <div class="dashboard-main-grid">
        
        <!-- Left: Recent Blood Requests Table -->
        <div class="table-card">
            <div class="section-header">
                <h3 class="section-title"><i class="fa-solid fa-list-check"></i> Recent Blood Requests</h3>
                <a href="AdminBloodRequests.aspx" class="btn-secondary-custom" style="font-size: 13px; padding: 6px 14px;">View All Requests</a>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>Req ID</th>
                        <th>Patient Name</th>
                        <th>Blood Group</th>
                        <th>Hospital</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptRecentRequests" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>#REQ-<%# Eval("RequestId") %></td>
                                <td><strong><%# Eval("PatientName") %></strong></td>
                                <td><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></td>
                                <td><%# Eval("HospitalName") %></td>
                                <td><%# Convert.ToDateTime(Eval("RequestDate")).ToString("dd MMM yyyy") %></td>
                                <td><span class="badge-pill badge-status-pending"><%# Eval("Status") %></span></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%# rptRecentRequests.Items.Count == 0 ? "<tr><td colspan='6'><div class='empty-placeholder'><i class='fa-solid fa-inbox'></i><p>No recent blood requests found.</p></div></td></tr>" : "" %>
                        </FooterTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <!-- Right: Blood Inventory Stock Status -->
        <div class="table-card">
            <div class="section-header">
                <h3 class="section-title"><i class="fa-solid fa-droplet text-danger"></i> Stock Level Status</h3>
                <a href="AdminBloodStock.aspx" class="btn-secondary-custom" style="font-size: 13px; padding: 6px 14px;">Manage</a>
            </div>

            <asp:Repeater ID="rptStockProgress" runat="server">
                <ItemTemplate>
                    <div class="stock-progress-item">
                        <div class="stock-progress-label">
                            <span><%# Eval("BloodGroup") %> Group</span>
                            <span style="color: #64748b;"><%# Eval("UnitsAvailable") %> / 100 Units</span>
                        </div>
                        <div class="progress-bar-bg">
                            <div class="progress-bar-fill" style='width: <%# Math.Min(Convert.ToInt32(Eval("UnitsAvailable")), 100) %>%; background: #dc2626;'></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>

</asp:Content>
