<%@ Page Title="Donor Dashboard" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonorDashboard.aspx.cs" Inherits="LifeFlow.DonorDashboard" %>

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
            border-left: 4px solid #e11d48;
            border-top: 1px solid #ffe4e6;
            border-right: 1px solid #ffe4e6;
            border-bottom: 1px solid #ffe4e6;
        }
        .stat-card-item:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(225,29,72,0.12); }
        .stat-info h4 { margin: 0 0 6px 0; font-size: 12px; color: #881337; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }
        .stat-info p { margin: 0; font-size: 28px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif; }
        .stat-icon { width: 52px; height: 52px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px; }
        .icon-red { background: #fee2e2; color: #e11d48; }
        .icon-rose { background: #ffe4e6; color: #be123c; }
        .icon-green { background: #dcfce7; color: #16a34a; }
        .icon-blue { background: #e0f2fe; color: #0284c7; }

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
            border: 1px solid #ffe4e6;
        }
        .quick-actions-bar h4 { margin: 0; font-size: 16px; font-weight: 600; color: #881337; }
        .action-buttons-group { display: flex; gap: 12px; flex-wrap: wrap; }

        .dashboard-main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }
        @media (max-width: 992px) { .dashboard-main-grid { grid-template-columns: 1fr; } }

        .eligibility-box {
            background: #fff;
            border-radius: 12px;
            padding: 22px;
            border: 1px solid #ffe4e6;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
        }
        .eligibility-badge {
            width: 60px; height: 60px; border-radius: 50%;
            background: #dcfce7; color: #16a34a;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px; margin: 0 auto 12px auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <!-- Top Stats Grid - Values set to 0 as instructed -->
    <div class="stats-grid">
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Total Donations</h4>
                <p><asp:Label ID="lblTotalDonations" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-red"><i class="fa-solid fa-heart-pulse"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Upcoming Appointments</h4>
                <p><asp:Label ID="lblUpcomingAppointments" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-rose"><i class="fa-solid fa-calendar-check"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Lives Saved</h4>
                <p><asp:Label ID="lblLivesSaved" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-green"><i class="fa-solid fa-hand-holding-heart"></i></div>
        </div>
        <div class="stat-card-item">
            <div class="stat-info">
                <h4>Reward Points</h4>
                <p><asp:Label ID="lblRewardPoints" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-icon icon-blue"><i class="fa-solid fa-award"></i></div>
        </div>
    </div>

    <!-- Quick Actions Bar -->
    <div class="quick-actions-bar">
        <h4><i class="fa-solid fa-bolt" style="color:#e11d48;"></i> Quick Actions</h4>
        <div class="action-buttons-group">
            <a href="DonationAppointment.aspx" class="btn-primary-custom"><i class="fa-solid fa-calendar-plus"></i> Book Appointment</a>
            <a href="MyDonations.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #0284c7, #0369a1);"><i class="fa-solid fa-clock-rotate-left"></i> Donation History</a>
            <a href="DonorCamps.aspx" class="btn-primary-custom" style="background: linear-gradient(135deg, #16a34a, #15803d);"><i class="fa-solid fa-tent"></i> View Camps</a>
        </div>
    </div>

    <!-- Main Grid -->
    <div class="dashboard-main-grid">
        <!-- Recent Donation History Table -->
        <div class="table-card">
            <div class="section-header">
                <h3 class="section-title"><i class="fa-solid fa-clock-rotate-left" style="color:#e11d48;"></i> Recent Donation History</h3>
                <a href="MyDonations.aspx" class="btn-secondary-custom" style="font-size:13px; padding:6px 14px;">View All</a>
            </div>
            <div class="table-responsive-wrapper">
                <asp:GridView ID="gvRecentDonations" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Donation ID">
                            <ItemTemplate><asp:Label ID="lblId" runat="server" Text='<%# "#DON-" + Eval("DonationId") %>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Center / Hospital">
                            <ItemTemplate><strong><%# Eval("CenterName") %></strong></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Blood Group">
                            <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Units">
                            <ItemTemplate><strong><%# Eval("Units") %> Units</strong></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate><%# Convert.ToDateTime(Eval("DonationDate")).ToString("dd MMM yyyy") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate><span class="badge-pill badge-status-verified"><%# Eval("Status") %></span></ItemTemplate>
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

        <!-- Right: Donor Eligibility Box -->
        <div class="eligibility-box">
            <div class="eligibility-badge">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <h4 style="margin: 0 0 6px 0; font-size: 17px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif;">Eligibility Status</h4>
            <p style="margin: 0 0 16px 0; font-size: 13px; color: #16a34a; font-weight: 600;">You are eligible to donate blood today!</p>
            <div style="text-align: left; background: #fff1f2; border: 1px solid #fecdd3; border-radius: 8px; padding: 12px; font-size: 12.5px; color: #881337; margin-bottom: 16px;">
                <p style="margin: 0 0 6px 0;"><i class="fa-solid fa-droplet" style="color:#e11d48;"></i> Registered Group: <strong><asp:Label ID="lblBloodGroup" runat="server" Text="O+"></asp:Label></strong></p>
                <p style="margin: 0;"><i class="fa-solid fa-calendar-day" style="color:#e11d48;"></i> Last Donation: <strong><asp:Label ID="lblLastDonationDate" runat="server" Text="None"></asp:Label></strong></p>
            </div>
            <a href="DonationAppointment.aspx" class="btn-primary-custom" style="width: 100%; justify-content: center;"><i class="fa-solid fa-calendar-plus"></i> Book Next Donation</a>
        </div>
    </div>

</asp:Content>
