<%@ Page Title="Blood Request Management" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="HospitalRequests.aspx.cs" Inherits="LifeFlow.HospitalRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .patient-info-cell strong { display: block; font-size: 13px; color: #134e4a; }
        .patient-info-cell span { font-size: 11px; color: #64748b; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-bed-pulse" style="color:#0d9488;"></i> Blood Request Management</h3>
        <button type="button" class="btn-primary-custom" onclick="openRequestModal()">
            <i class="fa-solid fa-plus"></i> Create Blood Request
        </button>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter Bar -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by patient name, blood group, doctor..."></asp:TextBox>
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
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
            <asp:ListItem Value="Approved">Approved</asp:ListItem>
            <asp:ListItem Value="Fulfilled">Fulfilled</asp:ListItem>
            <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Requests Table -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Req ID">
                        <ItemTemplate><asp:Label ID="lblReqId" runat="server" Text='<%# "#REQ-" + Eval("RequestId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Patient Details">
                        <ItemTemplate>
                            <div class="patient-info-cell">
                                <strong><%# Eval("PatientName") %></strong>
                                <span><%# Eval("DoctorName") != DBNull.Value && !string.IsNullOrEmpty(Eval("DoctorName").ToString()) ? "Dr. " + Eval("DoctorName") : "Hospital Request" %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Needed">
                        <ItemTemplate><strong><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("UnitsNeeded") + " Units" %>'></asp:Label></strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Urgency">
                        <ItemTemplate>
                            <span class='badge-pill badge-urgency-<%# Eval("Urgency").ToString().ToLower() %>'><%# Eval("Urgency") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Date">
                        <ItemTemplate><asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("RequestDate")).ToString("dd MMM yyyy") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge-pill badge-status-<%# Eval("Status").ToString().ToLower() %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditReq" CommandArgument='<%# Eval("RequestId") %>' CssClass="btn-icon-action btn-edit-act" ToolTip="Edit Request">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteReq" CommandArgument='<%# Eval("RequestId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Are you sure you want to delete this blood request?');" ToolTip="Delete Request">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-bed-pulse"></i>
                        <p style="margin:0; font-weight:500;">No blood requests found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Create Request Modal -->
    <div class="modal-backdrop-custom" id="modalRequest">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-bed-pulse"></i> Create Blood Request</h4>
                <button type="button" class="modal-close-btn" onclick="closeRequestModal()">&times;</button>
            </div>
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Patient Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtPatientName" runat="server" Placeholder="Full patient name"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Doctor Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtDoctorName" runat="server" Placeholder="Attending doctor"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Blood Group Required <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlBloodGroup" runat="server">
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
                        <label>Units Needed <span class="req">*</span></label>
                        <asp:TextBox ID="txtUnitsNeeded" runat="server" TextMode="Number" Placeholder="e.g. 2"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Urgency Level <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlUrgency" runat="server">
                            <asp:ListItem Value="Normal">Normal</asp:ListItem>
                            <asp:ListItem Value="Urgent">Urgent</asp:ListItem>
                            <asp:ListItem Value="Emergency">Emergency</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-field-group">
                        <label>Required By Date</label>
                        <asp:TextBox ID="txtRequiredDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Contact Phone <span class="req">*</span></label>
                        <asp:TextBox ID="txtContactPhone" runat="server" Placeholder="Patient/Guardian phone"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Ward / Department</label>
                        <asp:TextBox ID="txtWard" runat="server" Placeholder="e.g. ICU, Emergency"></asp:TextBox>
                    </div>
                    <div class="form-field-group full-width">
                        <label>Additional Notes</label>
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Any special requirements..."></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeRequestModal()">Cancel</button>
                <asp:Button ID="btnSubmitRequest" runat="server" Text="Submit Request" CssClass="btn-primary-custom" OnClick="btnSubmitRequest_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openRequestModal() { document.getElementById('modalRequest').classList.add('active'); }
        function closeRequestModal() { document.getElementById('modalRequest').classList.remove('active'); }
    </script>

</asp:Content>
