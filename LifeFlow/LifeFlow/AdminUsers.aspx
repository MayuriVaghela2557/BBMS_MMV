<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminUsers.aspx.cs" Inherits="LifeFlow.AdminUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .user-avatar-circle {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #e0f2fe;
            color: #0284c7;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 13px;
            margin-right: 10px;
            flex-shrink: 0;
        }
        .badge-role-admin { background: #fae8ff; color: #86198f; font-weight: 600; }
        .badge-role-donor { background: #fee2e2; color: #991b1b; font-weight: 600; }
        .badge-role-hospital { background: #dcfce7; color: #166534; font-weight: 600; }
        .badge-role-user { background: #e0f2fe; color: #075985; font-weight: 600; }
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

        .btn-action-edit {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 6px !important;
            padding: 6px 14px !important;
            background-color: #3b82f6 !important;
            color: #ffffff !important;
            border-radius: 6px !important;
            font-size: 13px !important;
            font-weight: 500 !important;
            text-decoration: none !important;
            border: none !important;
            cursor: pointer !important;
            white-space: nowrap !important;
            transition: all 0.2s ease !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .btn-action-edit:hover {
            background-color: #2563eb !important;
            color: #ffffff !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.3);
        }
        .btn-action-edit i {
            font-size: 13px !important;
            color: #ffffff !important;
        }

        .btn-action-delete {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 6px !important;
            padding: 6px 14px !important;
            background-color: #ef4444 !important;
            color: #ffffff !important;
            border-radius: 6px !important;
            font-size: 13px !important;
            font-weight: 500 !important;
            text-decoration: none !important;
            border: none !important;
            cursor: pointer !important;
            white-space: nowrap !important;
            transition: all 0.2s ease !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .btn-action-delete:hover {
            background-color: #dc2626 !important;
            color: #ffffff !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px -1px rgba(239, 68, 68, 0.3);
        }
        .btn-action-delete i {
            font-size: 13px !important;
            color: #ffffff !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">

    <!-- Page Top Header -->
    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-users text-info"></i> User Account Management</h3>
        <button type="button" class="btn-primary-custom" onclick="openAddUserModal()">
            <i class="fa-solid fa-user-plus"></i> Add New User
        </button>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Search & Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchUser" runat="server" Placeholder="Search by name, email, phone number..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterRole" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Roles</asp:ListItem>
            <asp:ListItem Value="Admin">Admin</asp:ListItem>
            <asp:ListItem Value="Donor">Donor</asp:ListItem>
            <asp:ListItem Value="Hospital">Hospital</asp:ListItem>
            <asp:ListItem Value="User">User</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Active">Active</asp:ListItem>
            <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterUsers" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterUsers_Click" />
    </div>

    <!-- Users Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="User ID">
                        <ItemTemplate>
                            <asp:Label ID="lblUserId" runat="server" Text='<%# "#USR-" + Eval("UserId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Name">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center;">
                                <div class="user-avatar-circle"><%# Eval("FullName").ToString().Substring(0, 1).ToUpper() %></div>
                                <strong><asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label></strong>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email Address">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="System Role">
                        <ItemTemplate>
                            <span class='<%# "badge-pill badge-role-" + Eval("Role").ToString().ToLower() %>'><%# Eval("Role") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("Status").ToString().ToLower() == "active" ? "badge-pill badge-status-active" : "badge-pill badge-status-inactive" %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Joined Date">
                        <ItemTemplate>
                            <asp:Label ID="lblCreated" runat="server" Text='<%# Eval("CreatedDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("UserId") %>' CssClass="btn-action-edit" ToolTip="Edit User">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteUser" CommandArgument='<%# Eval("UserId") %>' CssClass="btn-action-delete" OnClientClick="return confirm('Are you sure you want to delete this user?');" ToolTip="Delete User">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-users"></i>
                        <p style="margin:0; font-weight:500;">No users found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- ================= ADD NEW USER MODAL FORM ================= -->
    <div class="modal-backdrop-custom" id="modalAddUser">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-user-gear"></i> <span id="modalUserTitle">Add New User Account</span></h4>
                <button type="button" class="modal-close-btn" onclick="closeAddUserModal()">&times;</button>
            </div>
            
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Full Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtFullName" runat="server" Placeholder="Enter full name"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Email Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="user@example.com"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Phone Number <span class="req">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" Placeholder="e.g. 9876543210"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Role <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlRole" runat="server">
                            <asp:ListItem Value="User">Regular User</asp:ListItem>
                            <asp:ListItem Value="Donor">Donor</asp:ListItem>
                            <asp:ListItem Value="Hospital">Hospital</asp:ListItem>
                            <asp:ListItem Value="Admin">System Admin</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group">
                        <label>Status <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Value="Active">Active</asp:ListItem>
                            <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group">
                        <label>Password <span class="req">*</span></label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Set user password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeAddUserModal()">Cancel</button>
                <asp:Button ID="btnAddUser" runat="server" Text="Create Account" CssClass="btn-primary-custom" OnClick="btnAddUser_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAddUserModal() {
            var titleEl = document.getElementById('modalUserTitle');
            if (titleEl) titleEl.innerText = "Add New User Account";
            var btn = document.getElementById('<%= btnAddUser.ClientID %>');
            if (btn && btn.value === "Update") {
                btn.value = "Create Account";
                document.getElementById('<%= txtFullName.ClientID %>').value = "";
                document.getElementById('<%= txtEmail.ClientID %>').value = "";
                document.getElementById('<%= txtPhone.ClientID %>').value = "";
                document.getElementById('<%= txtPassword.ClientID %>').value = "";
            }
            document.getElementById('modalAddUser').classList.add('active');
        }

        function openEditUserModal() {
            var titleEl = document.getElementById('modalUserTitle');
            if (titleEl) titleEl.innerText = "Edit User Account";
            document.getElementById('modalAddUser').classList.add('active');
        }

        function closeAddUserModal() {
            document.getElementById('modalAddUser').classList.remove('active');
        }
    </script>

</asp:Content>
