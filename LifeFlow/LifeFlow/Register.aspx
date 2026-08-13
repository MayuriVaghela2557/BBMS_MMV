<%@ Page Title="Register | LifeLine Blood Bank" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LifeFlow.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ===================== PAGE HERO ===================== -->
  <section class="page-hero has-photo">
    <div class="container">
      <span class="eyebrow page-hero-eyebrow">Join the network</span>
      <h1>Create an Account</h1>
      <p>Register as a donor to get notified about nearby camps and track your donation history.</p>
      <div class="breadcrumbs"><a href="Home.aspx">Home</a> <i class="fa-solid fa-chevron-right" style="font-size:10px;"></i> <span>Register</span></div>
    </div>
    <svg class="pulse-divider on-dark" viewBox="0 0 1200 34" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 17 L140 17 L162 6 L184 28 L206 17 L360 17 L382 -2 L404 36 L426 17 L620 17 L642 4 L664 30 L686 17 L900 17 L922 8 L944 26 L966 17 L1200 17" />
    </svg>
  </section>

  <!-- ===================== REGISTER FORM ===================== -->
  <section class="auth-section">
    <div class="container">
      <div class="form-shell narrow">
        <div class="form-shell-head">
          <i class="fa-solid fa-user-plus"></i>
          <h2>Donor Registration</h2>
          <p>Fill out the form below to create your account.</p>
        </div>

        <asp:ValidationSummary ID="vsRegister" runat="server" ValidationGroup="vgRegister" CssClass="alert alert-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
        <asp:Label ID="lblRegisterMessage" runat="server" CssClass="form-message"></asp:Label>

        <div class="form-grid" style="grid-template-columns:1fr;">
          <div class="form-group">
            <label for="<%= txtRegName.ClientID %>">Full Name <span class="req">*</span></label>
            <asp:TextBox ID="txtRegName" runat="server" Placeholder="Enter your full name" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegName" runat="server" ControlToValidate="txtRegName" ErrorMessage="Full Name is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

            

          <div class="form-group">
            <label for="<%= txtRegEmail.ClientID %>">Email Address <span class="req">*</span></label>
            <asp:TextBox ID="txtRegEmail" runat="server" TextMode="Email" Placeholder="you@example.com" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Email is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revRegEmail" runat="server" ControlToValidate="txtRegEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email address format" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtRegPhone.ClientID %>">Phone Number <span class="req">*</span></label>
            <asp:TextBox ID="txtRegPhone" runat="server" Placeholder="+1 (555) 000-0000" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegPhone" runat="server" ControlToValidate="txtRegPhone" ErrorMessage="Phone number is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revRegPhone" runat="server" ControlToValidate="txtRegPhone" ValidationExpression="^\+?[0-9\s\-\(\)]{7,20}$" ErrorMessage="Invalid phone number format" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtRegAge.ClientID %>">Age <span class="req">*</span></label>
            <asp:TextBox ID="txtRegAge" runat="server" TextMode="Number" Placeholder="18 - 65" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegAge" runat="server" ControlToValidate="txtRegAge" ErrorMessage="Age is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
            <asp:RangeValidator ID="rvRegAge" runat="server" ControlToValidate="txtRegAge" MinimumValue="18" MaximumValue="65" Type="Integer" ErrorMessage="Age must be between 18 and 65" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= ddlRegGender.ClientID %>">Gender <span class="req">*</span></label>
            <asp:DropDownList ID="ddlRegGender" runat="server" CssClass="form-control">
              <asp:ListItem Value="">Select gender</asp:ListItem>
              <asp:ListItem Value="Male">Male</asp:ListItem>
              <asp:ListItem Value="Female">Female</asp:ListItem>
              <asp:ListItem Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRegGender" runat="server" ControlToValidate="ddlRegGender" InitialValue="" ErrorMessage="Gender is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= ddlRegBloodGroup.ClientID %>">Blood Group <span class="req">*</span></label>
            <asp:DropDownList ID="ddlRegBloodGroup" runat="server" CssClass="form-control">
              <asp:ListItem Value="">Select blood group</asp:ListItem>
              <asp:ListItem Value="A+">A+</asp:ListItem>
              <asp:ListItem Value="A-">A-</asp:ListItem>
              <asp:ListItem Value="B+">B+</asp:ListItem>
              <asp:ListItem Value="B-">B-</asp:ListItem>
              <asp:ListItem Value="AB+">AB+</asp:ListItem>
              <asp:ListItem Value="AB-">AB-</asp:ListItem>
              <asp:ListItem Value="O+">O+</asp:ListItem>
              <asp:ListItem Value="O-">O-</asp:ListItem>
              <asp:ListItem Value="Not sure">Not sure</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRegBloodGroup" runat="server" ControlToValidate="ddlRegBloodGroup" InitialValue="" ErrorMessage="Blood Group is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtRegCity.ClientID %>">City <span class="req">*</span></label>
            <asp:TextBox ID="txtRegCity" runat="server" Placeholder="Enter your city" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegCity" runat="server" ControlToValidate="txtRegCity" ErrorMessage="City is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtRegPassword.ClientID %>">Password <span class="req">*</span></label>
            <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" Placeholder="Create a password" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegPassword" runat="server" ControlToValidate="txtRegPassword" ErrorMessage="Password is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>

          <div class="form-group">
            <label for="<%= txtRegConfirmPassword.ClientID %>">Confirm Password <span class="req">*</span></label>
            <asp:TextBox ID="txtRegConfirmPassword" runat="server" TextMode="Password" Placeholder="Re-enter your password" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvRegConfirmPassword" runat="server" ControlToValidate="txtRegConfirmPassword" ErrorMessage="Confirm Password is required" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
            <asp:CompareValidator ID="cvRegPassword" runat="server" ControlToValidate="txtRegConfirmPassword" ControlToCompare="txtRegPassword" ErrorMessage="Passwords do not match" ValidationGroup="vgRegister" Display="Dynamic" ForeColor="Red" />
          </div>
        </div>

        <div class="form-actions" style="margin-top:20px;">
          <asp:Button ID="btnRegisterSubmit" runat="server" Text="Register" CssClass="btn btn-primary btn-block" ValidationGroup="vgRegister" OnClick="btnRegisterSubmit_Click" />
          <p class="form-note"><i class="fa-solid fa-circle-info"></i> Backend functionality will be implemented in Phase 3.</p>
        </div>

        <p class="form-foot-link" style="margin-top:16px; text-align:center;">Already have an account? <a href="Login.aspx">Login</a></p>
          <p class="form-foot-link" style="margin-top:16px; text-align:center;">&nbsp;</p>
          <p class="form-foot-link" style="margin-top:16px; text-align:center;">&nbsp;</p>
          <p class="form-foot-link" style="margin-top:16px; text-align:center;">&nbsp;</p>

          </div>
        </div>
            <div>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Height="315px" Width="961px" OnRowCommand="GridView1_RowCommand">
              <Columns>
                  <asp:TemplateField HeaderText="Full Name">
                      <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Eval("Full Name") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Email Address">
                      <ItemTemplate>
                          <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email Address") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Phone Number">
                      <ItemTemplate>
                          <asp:Label ID="Label3" runat="server" Text='<%# Eval("Phone Number") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Age">
                      <ItemTemplate>
                          <asp:Label ID="Label4" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Gender">
                      <ItemTemplate>
                          <asp:Label ID="Label5" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Blood Group">
                      <ItemTemplate>
                          <asp:Label ID="Label6" runat="server" Text='<%# Eval("Blood Group") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="City">
                      <ItemTemplate>
                          <asp:Label ID="Label7" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Password">
                      <ItemTemplate>
                          <asp:Label ID="Label8" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Confirm Password">
                      <ItemTemplate>
                          <asp:Label ID="Label9" runat="server" Text='<%# Eval("Confirm Password") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Edit">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="cmd_edt">Edit</asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Delete">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="cmd_dlt">Delete</asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
          </asp:GridView>
      </div>
    
  </section>
</asp:Content>
