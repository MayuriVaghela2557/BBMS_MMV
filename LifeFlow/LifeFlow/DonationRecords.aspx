<%@ Page Title="Donation Records" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="DonationRecords.aspx.cs" Inherits="LifeFlow.DonationRecords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .donor-avatar-small {
            width: 34px; height: 34px; border-radius: 50%;
            background: #ccfbf1; color: #0f766e;
            display: inline-flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 13px; margin-right: 8px; flex-shrink: 0;
        }
        .donor-cell { display: flex; align-items: center; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-heart-pulse" style="color:#0d9488;"></i> Donation Records</h3>
        <button type="button" class="btn-primary-custom" onclick="openAddDonationModal()">
            <i class="fa-solid fa-plus"></i> Add Donation Record
        </button>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter Bar -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by donor name, blood group, date..."></asp:TextBox>
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
        <asp:DropDownList ID="ddlFilterVerified" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Records</asp:ListItem>
            <asp:ListItem Value="Verified">Verified</asp:ListItem>
            <asp:ListItem Value="Pending">Pending Verification</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Donations Table -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Record ID">
                        <ItemTemplate><asp:Label ID="lblRecordId" runat="server" Text='<%# "#DON-" + Eval("DonationId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Donor Details">
                        <ItemTemplate>
                            <div class="donor-cell">
                                <div class="donor-avatar-small"><%# Eval("DonorName").ToString().Substring(0, 1).ToUpper() %></div>
                                <div>
                                    <strong><asp:Label ID="lblDonorName" runat="server" Text='<%# Eval("DonorName") %>'></asp:Label></strong>
                                    <div style="font-size:11px; color:#64748b;">Age: <%# Eval("DonorAge") %> | <%# Eval("DonorGender") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Donated">
                        <ItemTemplate><strong><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("UnitsDonated") + " Units" %>'></asp:Label></strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Donation Date">
                        <ItemTemplate><asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("DonationDate")).ToString("dd MMM yyyy") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Donor Contact">
                        <ItemTemplate><asp:Label ID="lblContact" runat="server" Text='<%# Eval("DonorPhone") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("VerificationStatus").ToString() == "Verified" ? "badge-status-approved" : "badge-status-pending" %>'>
                                <%# Eval("VerificationStatus") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnVerify" runat="server" CommandName="Verify" CommandArgument='<%# Eval("DonationId") %>' CssClass="btn-icon-action btn-verify-act" ToolTip="Verify Donation">
                                    <i class="fa-solid fa-circle-check"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditRecord" CommandArgument='<%# Eval("DonationId") %>' CssClass="btn-icon-action btn-edit-act" ToolTip="Edit Record">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteRecord" CommandArgument='<%# Eval("DonationId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Delete this donation record?');" ToolTip="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-heart-pulse"></i>
                        <p style="margin:0; font-weight:500;">No donation records found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Add Donation Modal -->
    <div class="modal-backdrop-custom" id="modalDonation">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-heart-pulse"></i> <span id="modalHeadingText">Add Donation Record</span></h4>
                <button type="button" class="modal-close-btn" onclick="closeDonationModal()">&times;</button>
            </div>
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Donor Full Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorName" runat="server" Placeholder="e.g. Ramesh Patel"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Donor Age <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorAge" runat="server" TextMode="Number" Placeholder="e.g. 28"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Gender <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlGender" runat="server">
                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <asp:ListItem Value="Male">Male</asp:ListItem>
                            <asp:ListItem Value="Female">Female</asp:ListItem>
                            <asp:ListItem Value="Other">Other</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-field-group">
                        <label>Blood Group <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlBloodGroup" runat="server">
                            <asp:ListItem Value="">-- Select --</asp:ListItem>
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
                        <label>Units Donated <span class="req">*</span></label>
                        <asp:TextBox ID="txtUnitsDonated" runat="server" TextMode="Number" Placeholder="e.g. 1"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Donation Date <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonationDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Donor Phone <span class="req">*</span></label>
                        <asp:TextBox ID="txtDonorPhone" runat="server" Placeholder="10-digit mobile number" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Donor Email</label>
                        <asp:TextBox ID="txtDonorEmail" runat="server" TextMode="Email" Placeholder="donor@example.com"></asp:TextBox>
                    </div>
                    <div class="form-field-group full-width">
                        <label>Health Notes / Remarks</label>
                        <asp:TextBox ID="txtHealthNotes" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Haemoglobin level, health condition, etc."></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeDonationModal()">Cancel</button>
                <asp:Button ID="btnSaveDonation" runat="server" Text="Save Record" CssClass="btn-primary-custom" OnClick="btnSaveDonation_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openDonationModal() {
            document.getElementById('modalDonation').classList.add('active');
        }
        function openAddDonationModal() {
            var btn = document.getElementById('<%= btnSaveDonation.ClientID %>');
            if (btn) btn.value = 'Save Record';
            var heading = document.getElementById('modalHeadingText');
            if (heading) heading.innerText = 'Add Donation Record';
            var name = document.getElementById('<%= txtDonorName.ClientID %>'); if (name) name.value = '';
            var age = document.getElementById('<%= txtDonorAge.ClientID %>'); if (age) age.value = '';
            var gen = document.getElementById('<%= ddlGender.ClientID %>'); if (gen) gen.selectedIndex = 0;
            var bg = document.getElementById('<%= ddlBloodGroup.ClientID %>'); if (bg) bg.selectedIndex = 0;
            var un = document.getElementById('<%= txtUnitsDonated.ClientID %>'); if (un) un.value = '';
            var dt = document.getElementById('<%= txtDonationDate.ClientID %>'); if (dt) dt.value = '';
            var ph = document.getElementById('<%= txtDonorPhone.ClientID %>'); if (ph) ph.value = '';
            var em = document.getElementById('<%= txtDonorEmail.ClientID %>'); if (em) em.value = '';
            var nt = document.getElementById('<%= txtHealthNotes.ClientID %>'); if (nt) nt.value = '';
            openDonationModal();
        }
        function closeDonationModal() {
            document.getElementById('modalDonation').classList.remove('active');
        }
    </script>

</asp:Content>
