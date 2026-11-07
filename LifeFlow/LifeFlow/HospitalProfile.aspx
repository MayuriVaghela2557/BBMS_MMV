<%@ Page Title="Hospital Profile" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="HospitalProfile.aspx.cs" Inherits="LifeFlow.HospitalProfile" %>

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
        }
        .hosp-avatar-circle {
            width: 90px; height: 90px; border-radius: 50%;
            background: linear-gradient(135deg, #0d9488, #5eead4);
            color: #fff; font-size: 36px; font-weight: 700;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px auto;
            box-shadow: 0 6px 18px rgba(13,148,136,0.3);
        }
        .profile-avatar-card h3 { margin: 0 0 6px; font-size: 18px; font-weight: 700; color: #134e4a; font-family: 'Poppins', sans-serif; }
        .profile-avatar-card p { margin: 0; font-size: 13px; color: #64748b; }
        .profile-detail-row { display: flex; gap: 8px; margin-bottom: 10px; align-items: flex-start; }
        .profile-detail-row i { color: #0d9488; width: 18px; margin-top: 2px; font-size: 14px; flex-shrink: 0; }
        .profile-detail-row span { font-size: 13px; color: #334155; }
        .profile-status-badge { display: inline-flex; align-items: center; gap: 6px; background: #ccfbf1; color: #0f766e; padding: 5px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; margin-top: 14px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-building-columns" style="color:#0d9488;"></i> Hospital Profile</h3>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <div class="profile-grid">
        <!-- Left: Profile Card -->
        <div class="profile-avatar-card">
            <div class="hosp-avatar-circle"><i class="fa-solid fa-hospital"></i></div>
            <h3><asp:Label ID="lblHospName" runat="server" Text="Hospital Name"></asp:Label></h3>
            <p><asp:Label ID="lblHospCity" runat="server" Text="City, State"></asp:Label></p>
            <div class="profile-status-badge"><i class="fa-solid fa-circle-check"></i> Active</div>
            <hr style="margin: 18px 0; border: none; border-top: 1px solid #e6faf7;" />
            <div style="text-align: left;">
                <div class="profile-detail-row"><i class="fa-solid fa-envelope"></i><span><asp:Label ID="lblHospEmail" runat="server" Text="email@hospital.com"></asp:Label></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-phone"></i><span><asp:Label ID="lblHospPhone" runat="server" Text="+91 00000 00000"></asp:Label></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-location-dot"></i><span><asp:Label ID="lblHospAddress" runat="server" Text="Full Address"></asp:Label></span></div>
                <div class="profile-detail-row"><i class="fa-solid fa-id-card"></i><span>Lic: <asp:Label ID="lblHospLicense" runat="server" Text="LIC-XXXXX"></asp:Label></span></div>
            </div>
        </div>

        <!-- Right: Edit Form -->
        <div class="table-card">
            <h4 style="margin: 0 0 20px; font-size: 16px; font-weight: 700; color: #134e4a; font-family: 'Poppins', sans-serif;"><i class="fa-solid fa-pen-to-square" style="color:#0d9488;"></i> Update Profile Information</h4>
            <div class="grid-form">
                <div class="form-field-group">
                    <label>Hospital Name <span class="req">*</span></label>
                    <asp:TextBox ID="txtHospName" runat="server" Placeholder="Full hospital name"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>License / Registration No <span class="req">*</span></label>
                    <asp:TextBox ID="txtLicenseNo" runat="server" Placeholder="e.g. LIC-AHM-9081"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Contact Person <span class="req">*</span></label>
                    <asp:TextBox ID="txtContactPerson" runat="server" Placeholder="Medical Officer name"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Email Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="hospital@example.com"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>Phone Number <span class="req">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" Placeholder="079-1234567"></asp:TextBox>
                </div>
                <div class="form-field-group">
                    <label>City <span class="req">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" Placeholder="e.g. Ahmedabad"></asp:TextBox>
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
                <div class="form-field-group">
                    <label>Pincode</label>
                    <asp:TextBox ID="txtPincode" runat="server" Placeholder="e.g. 380001" MaxLength="6"></asp:TextBox>
                </div>
                <div class="form-field-group full-width">
                    <label>Full Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Street address, landmark..."></asp:TextBox>
                </div>
            </div>
            <div style="margin-top: 20px; display: flex; justify-content: flex-end; gap: 10px;">
                <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Changes" CssClass="btn-primary-custom" OnClick="btnUpdateProfile_Click" />
            </div>
        </div>
    </div>

    <!-- Change Password Card -->
    <div class="table-card" style="margin-top: 20px;">
        <h4 style="margin: 0 0 20px; font-size: 16px; font-weight: 700; color: #134e4a; font-family: 'Poppins', sans-serif;"><i class="fa-solid fa-lock" style="color:#0d9488;"></i> Change Password</h4>
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
            <asp:Button ID="btnChangePass" runat="server" Text="Update Password" CssClass="btn-primary-custom" OnClick="btnChangePass_Click" />
        </div>
    </div>

</asp:Content>
