<%@ Page Title="Manage Camps" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminCamps.aspx.cs" Inherits="LifeFlow.AdminCamps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .camp-icon-avatar {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: #fef3c7;
            color: #d97706;
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
        <h3 class="section-title"><i class="fa-solid fa-tent text-warning"></i> Donation Camps Management</h3>
        <button type="button" class="btn-primary-custom" style="background: linear-gradient(135deg, #f59e0b, #d97706);" onclick="openAddCampModal()">
            <i class="fa-solid fa-plus"></i> Schedule New Camp
        </button>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter & Search Bar -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchCamp" runat="server" Placeholder="Search by camp title, venue, city, organizer..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterCampCity" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Cities</asp:ListItem>
            <asp:ListItem Value="Ahmedabad">Ahmedabad</asp:ListItem>
            <asp:ListItem Value="Surat">Surat</asp:ListItem>
            <asp:ListItem Value="Vadodara">Vadodara</asp:ListItem>
            <asp:ListItem Value="Rajkot">Rajkot</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlFilterCampStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Upcoming">Upcoming</asp:ListItem>
            <asp:ListItem Value="Ongoing">Ongoing</asp:ListItem>
            <asp:ListItem Value="Completed">Completed</asp:ListItem>
            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterCamps" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterCamps_Click" />
    </div>

    <!-- Camps Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Camp ID">
                        <ItemTemplate>
                            <asp:Label ID="lblCampId" runat="server" Text='<%# "#CMP-" + Eval("CampId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Camp Title & Organizer">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center;">
                                <div class="camp-icon-avatar"><i class="fa-solid fa-tent"></i></div>
                                <div>
                                    <strong><asp:Label ID="lblCampTitle" runat="server" Text='<%# Eval("CampTitle") %>'></asp:Label></strong>
                                    <div style="font-size:11px; color:#64748b;">Org: <%# Eval("Organizer") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date & Timing">
                        <ItemTemplate>
                            <div><i class="fa-solid fa-calendar" style="font-size:10px;"></i> <%# Convert.ToDateTime(Eval("CampDate")).ToString("dd MMM yyyy") %></div>
                            <div style="font-size:11px; color:#64748b;"><i class="fa-solid fa-clock" style="font-size:10px;"></i> <%# Eval("Timing") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Venue / City">
                        <ItemTemplate>
                            <asp:Label ID="lblVenueCity" runat="server" Text='<%# Eval("Venue") + ", " + Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Target Units">
                        <ItemTemplate>
                            <strong><asp:Label ID="lblTargetUnits" runat="server" Text='<%# Eval("TargetUnits") + " Units" %>'></asp:Label></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("Status").ToString() == "Upcoming" ? "badge-status-approved" : "badge-status-inactive" %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("CampId") %>' CssClass="btn-action-edit" ToolTip="Edit Camp">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteCamp" CommandArgument='<%# Eval("CampId") %>' CssClass="btn-action-delete" OnClientClick="return confirm('Are you sure you want to delete this donation camp?');" ToolTip="Delete Camp">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-tent"></i>
                        <p style="margin:0; font-weight:500;">No donation camps found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- ================= SCHEDULE NEW CAMP MODAL FORM ================= -->
    <div class="modal-backdrop-custom" id="modalAddCamp">
        <div class="modal-card">
            <div class="modal-card-header" style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                <h4><i class="fa-solid fa-tent"></i> <span id="modalCampTitle">Schedule New Blood Donation Camp</span></h4>
                <button type="button" class="modal-close-btn" onclick="closeAddCampModal()">&times;</button>
            </div>
            
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Camp Title <span class="req">*</span></label>
                        <asp:TextBox ID="txtCampTitle" runat="server" Placeholder="e.g. Mega Blood Drive 2026"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Organizer / Host <span class="req">*</span></label>
                        <asp:TextBox ID="txtOrganizer" runat="server" Placeholder="e.g. Red Cross Society"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Camp Date <span class="req">*</span></label>
                        <asp:TextBox ID="txtCampDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Timing <span class="req">*</span></label>
                        <asp:TextBox ID="txtTiming" runat="server" Placeholder="e.g. 09:00 AM - 05:00 PM"></asp:TextBox>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Venue Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtVenue" runat="server" Placeholder="Full venue address"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>City <span class="req">*</span></label>
                        <asp:TextBox ID="txtCampCity" runat="server" Placeholder="e.g. Ahmedabad"></asp:TextBox>
                    </div>

                    <div class="form-field-group">
                        <label>Target Units Goal <span class="req">*</span></label>
                        <asp:TextBox ID="txtTargetUnits" runat="server" TextMode="Number" Text="50" min="1"></asp:TextBox>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Status <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlCampStatus" runat="server">
                            <asp:ListItem Value="Upcoming">Upcoming</asp:ListItem>
                            <asp:ListItem Value="Ongoing">Ongoing</asp:ListItem>
                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeAddCampModal()">Cancel</button>
                <asp:Button ID="btnSaveCamp" runat="server" Text="Schedule Camp" CssClass="btn-primary-custom" Style="background: linear-gradient(135deg, #f59e0b, #d97706);" OnClick="btnSaveCamp_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAddCampModal() {
            var titleEl = document.getElementById('modalCampTitle');
            if (titleEl) titleEl.innerText = "Schedule New Blood Donation Camp";
            var btn = document.getElementById('<%= btnSaveCamp.ClientID %>');
            if (btn && btn.value === "Update") {
                btn.value = "Schedule Camp";
                document.getElementById('<%= txtCampTitle.ClientID %>').value = "";
                document.getElementById('<%= txtOrganizer.ClientID %>').value = "";
                document.getElementById('<%= txtCampDate.ClientID %>').value = "";
                document.getElementById('<%= txtTiming.ClientID %>').value = "";
                document.getElementById('<%= txtVenue.ClientID %>').value = "";
                document.getElementById('<%= txtCampCity.ClientID %>').value = "";
                document.getElementById('<%= txtTargetUnits.ClientID %>').value = "50";
            }
            document.getElementById('modalAddCamp').classList.add('active');
        }

        function openEditCampModal() {
            var titleEl = document.getElementById('modalCampTitle');
            if (titleEl) titleEl.innerText = "Edit Blood Donation Camp";
            document.getElementById('modalAddCamp').classList.add('active');
        }

        function closeAddCampModal() {
            document.getElementById('modalAddCamp').classList.remove('active');
        }
    </script>

</asp:Content>
