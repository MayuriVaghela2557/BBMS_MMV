<%@ Page Title="Manage Hospitals" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminHospitals.aspx.cs" Inherits="LifeFlow.AdminHospitals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hospital-icon-avatar {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: #dcfce7;
            color: #16a085;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            margin-right: 10px;
            flex-shrink: 0;
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

    <!-- Page Header Bar -->
    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-hospital text-success"></i> Hospital Management</h3>
        <button type="button" class="btn-primary-custom" style="background: linear-gradient(135deg, #10b981, #059669);" onclick="openAddHospitalModal()">
            <i class="fa-solid fa-plus"></i> Add New Hospital
        </button>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter & Search Bar -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchHospital" runat="server" Placeholder="Search by hospital name, city, phone..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterCity" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Cities</asp:ListItem>
            <asp:ListItem Value="Ahmedabad">Ahmedabad</asp:ListItem>
            <asp:ListItem Value="Surat">Surat</asp:ListItem>
            <asp:ListItem Value="Vadodara">Vadodara</asp:ListItem>
            <asp:ListItem Value="Rajkot">Rajkot</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Active">Active</asp:ListItem>
            <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterHospitals" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterHospitals_Click" />
    </div>

    <!-- Hospitals Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Hosp ID">
                        <ItemTemplate>
                            <asp:Label ID="lblHospId" runat="server" Text='<%# "#HSP-" + Eval("HospitalId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hospital Name">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center;">
                                <div class="hospital-icon-avatar"><i class="fa-solid fa-hospital"></i></div>
                                <div>
                                    <strong><asp:Label ID="lblHospName" runat="server" Text='<%# Eval("HospitalName") %>'></asp:Label></strong>
                                    <div style="font-size:11px; color:#64748b;"><%# Eval("City") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Contact Person">
                        <ItemTemplate>
                            <asp:Label ID="lblContact" runat="server" Text='<%# Eval("ContactPerson") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="License No">
                        <ItemTemplate>
                            <asp:Label ID="lblLicense" runat="server" Text='<%# Eval("LicenseNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("Status").ToString().ToLower() == "active" ? "badge-pill badge-status-active" : "badge-pill badge-status-inactive" %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("HospitalId") %>' CssClass="btn-action-edit" ToolTip="Edit Hospital">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteHospital" CommandArgument='<%# Eval("HospitalId") %>' CssClass="btn-action-delete" OnClientClick="return confirm('Are you sure you want to delete this hospital?');" ToolTip="Delete Hospital">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-hospital"></i>
                        <p style="margin:0; font-weight:500;">No hospitals found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- ================= ADD NEW HOSPITAL MODAL FORM ================= -->
    <div class="modal-backdrop-custom" id="modalAddHospital">
        <div class="modal-card">
            <div class="modal-card-header" style="background: linear-gradient(135deg, #10b981, #059669);">
                <h4><i class="fa-solid fa-hospital"></i> <span id="modalHospitalTitle">Add New Registered Hospital</span></h4>
                <button type="button" class="modal-close-btn" onclick="closeAddHospitalModal()">&times;</button>
            </div>
            
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Hospital Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtHospitalName" runat="server" Placeholder="Enter full hospital name"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>License / Reg Number <span class="req">*</span></label>
                        <asp:TextBox ID="txtLicenseNo" runat="server" Placeholder="e.g. LIC-AHM-9081"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Contact Person Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtContactPerson" runat="server" Placeholder="Medical Officer / Incharge Name"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Email Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="hospital@example.com"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Phone Number <span class="req">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" Placeholder="e.g. 079-1234567"></asp:TextBox>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Full Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Street address, landmark..."></asp:TextBox>
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

                    <div class="form-field-group">
                        <label>Status <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Value="Active">Active</asp:ListItem>
                            <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Account Password <span class="req">*</span></label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Set password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeAddHospitalModal()">Cancel</button>
                <asp:Button ID="btnAddHospital" runat="server" Text="Register Hospital" CssClass="btn-primary-custom" Style="background: linear-gradient(135deg, #10b981, #059669);" OnClick="btnAddHospital_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAddHospitalModal() {
            var titleEl = document.getElementById('modalHospitalTitle');
            if (titleEl) titleEl.innerText = "Add New Registered Hospital";
            var btn = document.getElementById('<%= btnAddHospital.ClientID %>');
            if (btn && btn.value === "Update") {
                btn.value = "Register Hospital";
                document.getElementById('<%= txtHospitalName.ClientID %>').value = "";
                document.getElementById('<%= txtLicenseNo.ClientID %>').value = "";
                document.getElementById('<%= txtContactPerson.ClientID %>').value = "";
                document.getElementById('<%= txtEmail.ClientID %>').value = "";
                document.getElementById('<%= txtPhone.ClientID %>').value = "";
                document.getElementById('<%= txtAddress.ClientID %>').value = "";
                document.getElementById('<%= txtCity.ClientID %>').value = "";
                document.getElementById('<%= txtPincode.ClientID %>').value = "";
                document.getElementById('<%= txtPassword.ClientID %>').value = "";
            }
            document.getElementById('modalAddHospital').classList.add('active');
        }

        function openEditHospitalModal() {
            var titleEl = document.getElementById('modalHospitalTitle');
            if (titleEl) titleEl.innerText = "Edit Registered Hospital";
            document.getElementById('modalAddHospital').classList.add('active');
        }

        function closeAddHospitalModal() {
            document.getElementById('modalAddHospital').classList.remove('active');
        }
    </script>

</asp:Content>
