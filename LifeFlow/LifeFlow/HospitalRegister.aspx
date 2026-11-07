<%@ Page Title="Hospital Registration | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HospitalRegister.aspx.cs" Inherits="LifeFlow.HospitalRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hosp-reg-card {
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border: 1px solid #ccfbf1;
            padding: 30px;
            margin: 30px auto;
            max-width: 800px;
        }
        .hosp-reg-head {
            text-align: center;
            margin-bottom: 25px;
        }
        .hosp-reg-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #ccfbf1;
            color: #0f766e;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 12px;
        }
        .hosp-reg-head h2 {
            font-size: 24px;
            font-weight: 700;
            color: #0f766e;
            margin: 0 0 6px 0;
            font-family: 'Poppins', sans-serif;
        }
        .hosp-reg-head p {
            color: #64748b;
            font-size: 14px;
            margin: 0;
        }
        .hosp-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }
        @media(max-width: 650px) {
            .hosp-form-grid { grid-template-columns: 1fr; }
        }
        .hosp-form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .hosp-form-group.full-width {
            grid-column: 1 / -1;
        }
        .hosp-form-group label {
            font-size: 13px;
            font-weight: 600;
            color: #134e4a;
        }
        .hosp-form-group label span.req {
            color: #ef4444;
        }
        .hosp-form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ccfbf1;
            border-radius: 8px;
            font-size: 13.5px;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }
        .hosp-form-control:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
        }
        .btn-hosp-reg {
            background: linear-gradient(135deg, #0d9488, #0f766e);
            color: #ffffff;
            border: none;
            padding: 12px 24px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(13,148,136,0.25);
        }
        .btn-hosp-reg:hover {
            opacity: 0.95;
            transform: translateY(-2px);
        }
        .hosp-reg-footer {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #64748b;
        }
        .hosp-reg-footer a {
            color: #0d9488;
            font-weight: 600;
            text-decoration: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- PAGE HERO -->
    <section class="page-hero has-photo">
        <div class="container">
            <span class="eyebrow page-hero-eyebrow">Partner with LifeFlow</span>
            <h1>Hospital Registration</h1>
            <p>Register your hospital or medical institution to manage blood units and patient requests.</p>
            <div class="breadcrumbs">
                <a href="Home.aspx">Home</a> 
                <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> 
                <span>Hospital Registration</span>
            </div>
        </div>
        <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
            <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
        </svg>
    </section>

    <!-- REGISTRATION FORM -->
    <div class="container" style="padding: 20px 0 40px 0;">
        <div class="hosp-reg-card">
            <div class="hosp-reg-head">
                <div class="hosp-reg-icon">
                    <i class="fa-solid fa-hospital"></i>
                </div>
                <h2>Hospital Registration</h2>
                <p>Fill out the official hospital details and credentials to join our life-saving network.</p>
            </div>

            <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

            <div class="hosp-form-grid">
                <!-- Hospital Name -->
                <div class="hosp-form-group">
                    <label>Hospital Name <span class="req">*</span></label>
                    <asp:TextBox ID="txtHospitalName" runat="server" CssClass="hosp-form-control" Placeholder="e.g. Apollo Hospital"></asp:TextBox>
                </div>

                <!-- License No -->
                <div class="hosp-form-group">
                    <label>License / Registration No <span class="req">*</span></label>
                    <asp:TextBox ID="txtLicenseNo" runat="server" CssClass="hosp-form-control" Placeholder="e.g. LIC-AHM-9081"></asp:TextBox>
                </div>

                <!-- Contact Person -->
                <div class="hosp-form-group">
                    <label>Contact Person / Medical Officer <span class="req">*</span></label>
                    <asp:TextBox ID="txtContactPerson" runat="server" CssClass="hosp-form-control" Placeholder="Incharge / Doctor Name"></asp:TextBox>
                </div>

                <!-- Contact Number -->
                <div class="hosp-form-group">
                    <label>Contact Number <span class="req">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="hosp-form-control" Placeholder="Phone / Mobile number"></asp:TextBox>
                </div>

                <!-- Email Address -->
                <div class="hosp-form-group">
                    <label>Official Email Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="hosp-form-control" Placeholder="hospital@example.com"></asp:TextBox>
                </div>

                <!-- City -->
                <div class="hosp-form-group">
                    <label>City <span class="req">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="hosp-form-control" Placeholder="e.g. Ahmedabad"></asp:TextBox>
                </div>

                <!-- State -->
                <div class="hosp-form-group">
                    <label>State <span class="req">*</span></label>
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="hosp-form-control">
                        <asp:ListItem Value="Gujarat">Gujarat</asp:ListItem>
                        <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                        <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                        <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Pincode -->
                <div class="hosp-form-group">
                    <label>Pincode</label>
                    <asp:TextBox ID="txtPincode" runat="server" CssClass="hosp-form-control" Placeholder="e.g. 380001" MaxLength="6"></asp:TextBox>
                </div>

                <!-- Address -->
                <div class="hosp-form-group full-width">
                    <label>Complete Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="hosp-form-control" Placeholder="Street address, landmark, area..."></asp:TextBox>
                </div>

                <!-- Login Username -->
                <div class="hosp-form-group">
                    <label>Login Username <span class="req">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="hosp-form-control" Placeholder="Choose username"></asp:TextBox>
                </div>

                <!-- Login Password -->
                <div class="hosp-form-group">
                    <label>Login Password <span class="req">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="hosp-form-control" Placeholder="Create secure password"></asp:TextBox>
                </div>

                <!-- Submit Button -->
                <div class="hosp-form-group full-width" style="margin-top: 15px;">
                    <asp:Button ID="btnRegister" runat="server" Text="Register Hospital" CssClass="btn-hosp-reg" OnClick="btnRegister_Click" />
                </div>
            </div>

            <div class="hosp-reg-footer">
                Already registered? <a href="HospitalLogin.aspx">Login to Hospital Panel</a>
            </div>
        </div>
    </div>
</asp:Content>
