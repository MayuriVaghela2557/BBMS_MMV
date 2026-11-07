<%@ Page Title="Manage Donors" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminDonors.aspx.cs" Inherits="LifeFlow.AdminDonors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .donor-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #fee2e2;
            color: #dc2626;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 13px;
            margin-right: 10px;
            flex-shrink: 0;
        }
        .donor-meta { font-size: 11px; color: #64748b; }
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
            padding: 6px 12px !important;
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
            padding: 6px 12px !important;
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
    
    <!-- Page Top Action Bar -->
    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-hand-holding-droplet text-danger"></i> Donor Management</h3>
        <button type="button" class="btn-primary-custom" onclick="openAddDonorModal()">
            <i class="fa-solid fa-plus"></i> Add New Donor
        </button>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Search & Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchDonor" runat="server" Placeholder="Search by donor name, phone number, email..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterBloodGroup" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Blood Groups</asp:ListItem>
            <asp:ListItem Value="A+">A+</asp:ListItem>
            <asp:ListItem Value="A-">A-</asp:ListItem>
            <asp:ListItem Value="B+">B+</asp:ListItem>
            <asp:ListItem Value="B-">B-</asp:ListItem>
            <asp:ListItem Value="O+">O+</asp:ListItem>
            <asp:ListItem Value="O-">O-</asp:ListItem>
            <asp:ListItem Value="AB+">AB+</asp:ListItem>
            <asp:ListItem Value="AB-">AB-</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlFilterCity" runat="server" CssClass="filter-select" OnSelectedIndexChanged="ddlFilterCity_SelectedIndexChanged">
            <asp:ListItem Value="">All Cities</asp:ListItem>
            <asp:ListItem Value="Ahmedabad">Ahmedabad</asp:ListItem>
            <asp:ListItem Value="Surat">Surat</asp:ListItem>
            <asp:ListItem Value="Vadodara">Vadodara</asp:ListItem>
            <asp:ListItem Value="Rajkot">Rajkot</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterDonors" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterDonors_Click" />
    </div>

    <!-- Donors Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand" >
                <Columns>
                    <asp:TemplateField HeaderText="Donor ID">
                        <ItemTemplate>
                            <asp:Label ID="lblDonorId" runat="server" Text='<%# "#DNR-" + Eval("DonorId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Full Name">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center;">
                                <div class="donor-avatar"><%# Eval("FullName").ToString().Substring(0, 1).ToUpper() %></div>
                                <div>
                                    <strong><asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label></strong>
                                    <div class="donor-meta"><%# Eval("Gender") %>, <%# Eval("Age") %> yrs</div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate>
                            <span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="State">
                        <ItemTemplate>
                            <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge-pill badge-status-active"><%# Eval("HealthStatus") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("DonorId") %>' CssClass="btn-action-edit" ToolTip="Edit Donor">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteDonor" CommandArgument='<%# Eval("DonorId") %>' CssClass="btn-action-delete" OnClientClick="return confirm('Are you sure you want to delete this donor?');" ToolTip="Delete Donor">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-hand-holding-droplet"></i>
                        <p style="margin:0; font-weight:500;">No donors found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- ================= ADD NEW DONOR MODAL FORM ================= -->

    <div class="modal-backdrop-custom" id="modalAddDonor">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-hand-holding-droplet"></i> Add New Blood Donor</h4>
                <button type="button" class="modal-close-btn" onclick="closeAddDonorModal()">&times;</button>
            </div>
            
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Full Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorName" runat="server" Placeholder="e.g. Ramesh Kumar"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Age <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorAge" runat="server" TextMode="Number" Placeholder="e.g. 25"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Gender <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlDonorGender" runat="server">
                            <asp:ListItem Value="">-- Select Gender --</asp:ListItem>
                            <asp:ListItem Value="Male">Male</asp:ListItem>
                            <asp:ListItem Value="Female">Female</asp:ListItem>
                            <asp:ListItem Value="Other">Other</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group">
                        <label>Blood Group <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlDonorBloodGroup" runat="server">
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

                    <div class="form-field-group">
                        <label>Mobile Number <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorMobile" runat="server" Placeholder="e.g. 9876543210" MaxLength="10"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Email Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorEmail" runat="server" TextMode="Email" Placeholder="donor@example.com"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>City <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorCity" runat="server" Placeholder="e.g. Ahmedabad"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>State <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlDonorState" runat="server">
                            <asp:ListItem Value="Gujarat">Gujarat</asp:ListItem>
                            <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                            <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                            <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Residential Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorAddress" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Enter complete address"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Last Donation Date</label>
                        <asp:TextBox ID="txtLastDonationDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Eligibility / Health Status <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlHealthStatus" runat="server">
                            <asp:ListItem Value="Eligible">Fit & Eligible to Donate</asp:ListItem>
                            <asp:ListItem Value="Deferred">Temporary Deferred</asp:ListItem>
                            <asp:ListItem Value="Unfit">Permanently Unfit</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Create Account Password <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorPassword" runat="server" TextMode="Password" Placeholder="Set password for donor portal login"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeAddDonorModal()">Cancel</button>
                <asp:Button ID="btnAddDonor" runat="server" Text="Save Donor" CssClass="btn-primary-custom" OnClick="btnAddDonor_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAddDonorModal() {
            document.getElementById('modalAddDonor').classList.add('active');
        }
        function closeAddDonorModal() {
            document.getElementById('modalAddDonor').classList.remove('active');
        }
    </script>

</asp:Content>
