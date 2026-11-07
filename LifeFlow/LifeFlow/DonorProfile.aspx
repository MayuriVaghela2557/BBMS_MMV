<%@ Page Title="Donor Profile" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonorProfile.aspx.cs" Inherits="LifeFlow.DonorProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 24px; }
        @media (max-width: 900px) { .profile-grid { grid-template-columns: 1fr; } }
        .profile-avatar-card {
            background: #fff;
            border-radius: 14px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #ffe4e6;
        }
        .donor-avatar-circle {
            width: 90px; height: 90px; border-radius: 50%;
            background: linear-gradient(135deg, #e11d48, #be123c);
            color: #fff; font-size: 36px; font-weight: 700;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px auto;
            box-shadow: 0 6px 18px rgba(225,29,72,0.3);
        }
        .profile-avatar-card h3 { margin: 0 0 6px; font-size: 18px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif; }
        .profile-avatar-card p { margin: 0; font-size: 13px; color: #881337; }
        .profile-detail-row { display: flex; gap: 8px; margin-bottom: 10px; align-items: flex-start; }
        .profile-detail-row i { color: #e11d48; width: 18px; margin-top: 2px; font-size: 14px; flex-shrink: 0; }
        .profile-detail-row span { font-size: 13px; color: #334155; }
        .profile-status-badge { display: inline-flex; align-items: center; gap: 6px; background: #dcfce7; color: #15803d; padding: 5px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; margin-top: 14px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-user-circle" style="color:#e11d48;"></i> Donor Profile</h3>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <div class="profile-grid">
        <!-- Left: Profile Summary Card -->
        <div class="profile-avatar-card">
            <div class="donor-avatar-circle"><i class="fa-solid fa-user"></i></div>
            <h3><asp:Label ID="lblCardName" runat="server" Text="Donor Name"></asp:Label></h3>
            <p><asp:Label ID="lblCardCity" runat="server" Text="Ahmedabad, Gujarat"></asp:Label></p>
            <div class="profile-status-badge"><i class="fa-solid fa-circle-check"></i> Eligible Donor</div>
            <hr style="margin: 18px 0; border: none; border-top: 1px solid #ffe4e6;" />
            <div style="text-align: left;">
                <div class="profile-detail-row"><i class="fa-solid fa-droplet"></i><span>Blood Group: <strong><asp:Label ID="lblCardBloodGroup" runat="server" Text="O+"></asp:Label></strong></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-envelope"></i><span><asp:Label ID="lblCardEmail" runat="server" Text="donor@example.com"></asp:Label></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-phone"></i><span><asp:Label ID="lblCardPhone" runat="server" Text="+91 98765 43210"></asp:Label></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-location-dot"></i><span><asp:Label ID="lblCardAddress" runat="server" Text="Full Address"></asp:Label></span></div>
            </div>
        </div>

        <!-- Right: Edit Details Form -->
        <div class="table-card">
            <h4 style="margin: 0 0 20px; font-size: 16px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif;"><i class="fa-solid fa-pen-to-square" style="color:#e11d48;"></i> Update Personal Information</h4>
            <div class="grid-form">
                <div class="form-field-group">
                    <label>Full Name <span class="req">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" Placeholder="Full name"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Blood Group</label>
                    <asp:TextBox ID="txtBloodGroup" runat="server" ReadOnly="true" BackColor="#f8fafc"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Contact Phone <span class="req">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" Placeholder="Mobile number"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Email Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="Email"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>City <span class="req">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" Placeholder="City"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>State <span class="req">*</span></label>
                    <asp:DropDownList ID="ddlState" runat="server">
                        <asp:ListItem Value="Gujarat">Gujarat</asp:ListItem>
                        <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                        <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                        <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-field-group full-width">
                    <label>Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Street address, landmark..."></asp:TextBox>
                </div>
            </div>
            <div style="margin-top: 20px; display: flex; justify-content: flex-end;">
                <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Profile" CssClass="btn-primary-custom" OnClick="btnUpdateProfile_Click" />
            </div>
        </div>
    </div>

    <!-- Password Change Section -->
    <div class="table-card" style="margin-top: 20px;">
        <h4 style="margin: 0 0 20px; font-size: 16px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif;"><i class="fa-solid fa-lock" style="color:#e11d48;"></i> Change Password</h4>
        <div class="grid-form">
            <div class="form-field-group">
                <label>Current Password <span class="req">*</span></label>
                <asp:TextBox ID="txtCurrentPass" runat="server" TextMode="Password" Placeholder="Enter current password"></asp:TextBox>
            </div>
            <div class="form-field-group" style="grid-column: 1;">
                <label>New Password <span class="req">*</span></label>
                <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
            </div>
            <div class="form-field-group">
                <label>Confirm New Password <span class="req">*</span></label>
                <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>
            </div>
        </div>
        <div style="margin-top: 20px; display: flex; justify-content: flex-end;">
            <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn-primary-custom" OnClick="btnChangePassword_Click" />
        </div>
    </div>

</asp:Content>
