<%@ Page Title="Donor Registration | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DonorRegister.aspx.cs" Inherits="LifeFlow.DonorRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .donor-reg-card {
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border: 1px solid #fecdd3;
            padding: 30px;
            margin: 30px auto;
            max-width: 800px;
        }
        .donor-reg-head {
            text-align: center;
            margin-bottom: 25px;
        }
        .donor-reg-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #ffe4e6;
            color: #e11d48;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 12px;
        }
        .donor-reg-head h2 {
            font-size: 24px;
            font-weight: 700;
            color: #881337;
            margin: 0 0 6px 0;
            font-family: 'Poppins', sans-serif;
        }
        .donor-reg-head p {
            color: #64748b;
            font-size: 14px;
            margin: 0;
        }
        .donor-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }
        @media(max-width: 650px) {
            .donor-form-grid { grid-template-columns: 1fr; }
        }
        .donor-form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .donor-form-group.full-width {
            grid-column: 1 / -1;
        }
        .donor-form-group label {
            font-size: 13px;
            font-weight: 600;
            color: #4c0519;
        }
        .donor-form-group label span.req {
            color: #e11d48;
        }
        .donor-form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #fecdd3;
            border-radius: 8px;
            font-size: 13.5px;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }
        .donor-form-control:focus {
            border-color: #e11d48;
            box-shadow: 0 0 0 3px rgba(225,29,72,0.15);
        }
        .btn-donor-reg {
            background: linear-gradient(135deg, #e11d48, #be123c);
            color: #ffffff;
            border: none;
            padding: 12px 24px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(225,29,72,0.25);
        }
        .btn-donor-reg:hover {
            opacity: 0.95;
            transform: translateY(-2px);
        }
        .donor-reg-footer {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #64748b;
        }
        .donor-reg-footer a {
            color: #e11d48;
            font-weight: 600;
            text-decoration: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- PAGE HERO -->
    <section class="page-hero has-photo">
        <div class="container">
            <span class="eyebrow page-hero-eyebrow">Become a Hero</span>
            <h1>Donor Registration</h1>
            <p>Register as a blood donor and help save lives across Gujarat and India.</p>
            <div class="breadcrumbs">
                <a href="Home.aspx">Home</a> 
                <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> 
                <span>Donor Registration</span>
            </div>
        </div>
        <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
            <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
        </svg>
    </section>

    <!-- REGISTRATION FORM -->
    <div class="container" style="padding: 20px 0 40px 0;">
        <div class="donor-reg-card">
            <div class="donor-reg-head">
                <div class="donor-reg-icon">
                    <i class="fa-solid fa-hand-holding-droplet"></i>
                </div>
                <h2>Register as Blood Donor</h2>
                <p>Provide your personal details, blood group and create your donor login account.</p>
            </div>

            <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

            <div class="donor-form-grid">
                <!-- Full Name -->
                <div class="donor-form-group">
                    <label>Full Name <span class="req">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="donor-form-control" Placeholder="e.g. Ramesh Kumar"></asp:TextBox>
                </div>

                <!-- Date of Birth / Age -->
                <div class="donor-form-group">
                    <label>Date of Birth <span class="req">*</span></label>
                    <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="donor-form-control"></asp:TextBox>
                </div>

                <!-- Gender -->
                <div class="donor-form-group">
                    <label>Gender <span class="req">*</span></label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="donor-form-control">
                        <asp:ListItem Value="">-- Select Gender --</asp:ListItem>
                        <asp:ListItem Value="Male">Male</asp:ListItem>
                        <asp:ListItem Value="Female">Female</asp:ListItem>
                        <asp:ListItem Value="Other">Other</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Blood Group -->
                <div class="donor-form-group">
                    <label>Blood Group <span class="req">*</span></label>
                    <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="donor-form-control">
                        <asp:ListItem Value="">-- Select Blood Group --</asp:ListItem>
                        <asp:ListItem Value="A+">A+</asp:ListItem>
                        <asp:ListItem Value="A-">A-</asp:ListItem>
                        <asp:ListItem Value="B+">B+</asp:ListItem>
                        <asp:ListItem Value="B-">B-</asp:ListItem>
                        <asp:ListItem Value="O+">O+</asp:ListItem>
                        <asp:ListItem Value="O-">O-</asp:ListItem>
                        <asp:ListItem Value="AB+">AB+</asp:ListItem>
                        <asp:ListItem Value="AB-">AB-</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Contact Mobile -->
                <div class="donor-form-group">
                    <label>Contact Mobile Number <span class="req">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="donor-form-control" Placeholder="10-digit mobile number" MaxLength="10"></asp:TextBox>
                </div>

                <!-- Email -->
                <div class="donor-form-group">
                    <label>Email Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="donor-form-control" Placeholder="donor@example.com"></asp:TextBox>
                </div>

                <!-- City -->
                <div class="donor-form-group">
                    <label>City <span class="req">*</span></label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="donor-form-control" Placeholder="e.g. Ahmedabad"></asp:TextBox>
                </div>

                <!-- State -->
                <div class="donor-form-group">
                    <label>State <span class="req">*</span></label>
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="donor-form-control">
                        <asp:ListItem Value="Gujarat">Gujarat</asp:ListItem>
                        <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                        <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                        <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Complete Address -->
                <div class="donor-form-group full-width">
                    <label>Address <span class="req">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="donor-form-control" Placeholder="House no, Street, Area..."></asp:TextBox>
                </div>

                <!-- Username -->
                <div class="donor-form-group">
                    <label>Login Username / Email <span class="req">*</span></label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="donor-form-control" Placeholder="Choose username"></asp:TextBox>
                </div>

                <!-- Password -->
                <div class="donor-form-group">
                    <label>Login Password <span class="req">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="donor-form-control" Placeholder="Create password"></asp:TextBox>
                </div>

                <!-- Submit Button -->
                <div class="donor-form-group full-width" style="margin-top: 15px;">
                    <asp:Button ID="btnRegister" runat="server" Text="Complete Registration" CssClass="btn-donor-reg" OnClick="btnRegister_Click" />
                </div>
            </div>

            <div class="donor-reg-footer">
                Already registered? <a href="DonorLogin.aspx">Login to Donor Portal</a>
            </div>
        </div>
    </div>
</asp:Content>
