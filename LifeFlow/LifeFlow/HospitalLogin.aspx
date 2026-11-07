<%@ Page Title="Hospital Login | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HospitalLogin.aspx.cs" Inherits="LifeFlow.HospitalLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hosp-login-card {
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border: 1px solid #ccfbf1;
            padding: 35px 30px;
            margin: 40px auto;
            max-width: 480px;
        }
        .hosp-login-head {
            text-align: center;
            margin-bottom: 25px;
        }
        .hosp-login-icon {
            width: 65px;
            height: 65px;
            border-radius: 50%;
            background: #ccfbf1;
            color: #0f766e;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 12px;
        }
        .hosp-login-head h2 {
            font-size: 24px;
            font-weight: 700;
            color: #0f766e;
            margin: 0 0 6px 0;
            font-family: 'Poppins', sans-serif;
        }
        .hosp-login-head p {
            color: #64748b;
            font-size: 13.5px;
            margin: 0;
        }
        .hosp-login-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 18px;
        }
        .hosp-login-group label {
            font-size: 13px;
            font-weight: 600;
            color: #134e4a;
        }
        .hosp-login-control {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #ccfbf1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }
        .hosp-login-control:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
        }
        .btn-hosp-login {
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
            margin-top: 5px;
        }
        .btn-hosp-login:hover {
            opacity: 0.95;
            transform: translateY(-2px);
        }
        .hosp-login-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #64748b;
        }
        .hosp-login-footer a {
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
            <span class="eyebrow page-hero-eyebrow">Medical Portal Access</span>
            <h1>Hospital Login</h1>
            <p>Access your dedicated hospital panel to manage blood stocks and requests.</p>
            <div class="breadcrumbs">
                <a href="Home.aspx">Home</a> 
                <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> 
                <span>Hospital Login</span>
            </div>
        </div>
        <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
            <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
        </svg>
    </section>

    <!-- LOGIN FORM -->
    <div class="container" style="padding: 20px 0 50px 0;">
        <div class="hosp-login-card">
            <div class="hosp-login-head">
                <div class="hosp-login-icon">
                    <i class="fa-solid fa-hospital-user"></i>
                </div>
                <h2>Hospital Portal Login</h2>
                <p>Verify credentials to manage your hospital's blood banking operations.</p>
            </div>

            <asp:Label ID="lblLoginMsg" runat="server" EnableViewState="false"></asp:Label>

            <div class="hosp-login-group">
                <label>Username / Email Address <span style="color:#ef4444;">*</span></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="hosp-login-control" Placeholder="Enter registered username or email"></asp:TextBox>
            </div>

            <div class="hosp-login-group">
                <label>Password <span style="color:#ef4444;">*</span></label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="hosp-login-control" Placeholder="Enter your password"></asp:TextBox>
            </div>

            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px; font-size:13px;">
                <label style="display:flex; align-items:center; gap:6px; cursor:pointer;">
                    <asp:CheckBox ID="chkRemember" runat="server" /> Remember me
                </label>
                <a href="#" style="color:#0d9488; text-decoration:none;">Forgot Password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign In to Portal" CssClass="btn-hosp-login" OnClick="btnLogin_Click" />

            <div class="hosp-login-footer">
                New hospital? <a href="HospitalRegister.aspx">Register your hospital here</a>
            </div>
        </div>
    </div>
</asp:Content>
