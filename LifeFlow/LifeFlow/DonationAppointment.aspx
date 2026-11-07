<%@ Page Title="Donation Appointment" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonationAppointment.aspx.cs" Inherits="LifeFlow.DonationAppointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .appointment-form-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 24px;
            border: 1px solid #ffe4e6;
            margin-bottom: 25px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-calendar-plus" style="color:#e11d48;"></i> Book Donation Appointment</h3>
        <button type="button" class="btn-primary-custom" onclick="openAppModal()">
            <i class="fa-solid fa-plus"></i> New Appointment
        </button>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by Center, Hospital or Camp..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding:9px 16px;" OnClick="btnFilter_Click" />
    </div>

    <!-- Appointments GridView -->
    <div class="table-card">
        <div class="section-header">
            <h3 class="section-title"><i class="fa-solid fa-calendar-check" style="color:#e11d48;"></i> My Appointments</h3>
        </div>
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="App ID">
                        <ItemTemplate><asp:Label ID="lblAppId" runat="server" Text='<%# "#APP-" + Eval("AppointmentId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Center / Hospital / Camp">
                        <ItemTemplate><strong><%# Eval("CenterName") %></strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate><span class="badge-pill badge-status-active"><%# Eval("CenterType") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Appointment Date">
                        <ItemTemplate><%# Convert.ToDateTime(Eval("AppointmentDate")).ToString("dd MMM yyyy") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Time Slot">
                        <ItemTemplate><i class="fa-solid fa-clock" style="font-size:11px; color:#e11d48;"></i> <%# Eval("TimeSlot") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("Status").ToString() == "Confirmed" ? "badge-status-confirmed" : Eval("Status").ToString() == "Pending" ? "badge-status-pending" : "badge-status-cancelled" %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditApp" CommandArgument='<%# Eval("AppointmentId") %>' CssClass="btn-icon-action btn-edit-act" ToolTip="Edit Appointment">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="DeleteApp" CommandArgument='<%# Eval("AppointmentId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Cancel this appointment?');" ToolTip="Cancel Appointment">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-calendar-xmark"></i>
                        <p style="margin:0; font-weight:500;">No appointments booked yet.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Book Appointment Modal -->
    <div class="modal-backdrop-custom" id="modalApp">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-calendar-plus"></i> Book Blood Donation Appointment</h4>
                <button type="button" class="modal-close-btn" onclick="closeAppModal()">&times;</button>
            </div>
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Donation Location Type <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlLocationType" runat="server">
                            <asp:ListItem Value="Hospital">Hospital / Blood Bank</asp:ListItem>
                            <asp:ListItem Value="Donation Camp">Donation Camp</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-field-group">
                        <label>Select Hospital or Camp <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlCenter" runat="server">
                            <asp:ListItem Value="Civil Hospital Blood Bank, Ahmedabad">Civil Hospital Blood Bank, Ahmedabad</asp:ListItem>
                            <asp:ListItem Value="Red Cross Society, Ellisbridge">Red Cross Society, Ellisbridge</asp:ListItem>
                            <asp:ListItem Value="Mega Blood Donation Drive 2026, Vastrapur">Mega Blood Donation Drive 2026, Vastrapur</asp:ListItem>
                            <asp:ListItem Value="Apollo Hospital, Gandhinagar">Apollo Hospital, Gandhinagar</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-field-group">
                        <label>Preferred Date <span class="req">*</span></label>
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Time Slot <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlTimeSlot" runat="server">
                            <asp:ListItem Value="09:00 AM - 11:00 AM">09:00 AM - 11:00 AM</asp:ListItem>
                            <asp:ListItem Value="11:00 AM - 01:00 PM">11:00 AM - 01:00 PM</asp:ListItem>
                            <asp:ListItem Value="02:00 PM - 04:00 PM">02:00 PM - 04:00 PM</asp:ListItem>
                            <asp:ListItem Value="04:00 PM - 06:00 PM">04:00 PM - 06:00 PM</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-field-group full-width">
                        <label>Notes / Special Request</label>
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Any prior health notes..."></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeAppModal()">Cancel</button>
                <asp:Button ID="btnBook" runat="server" Text="Confirm Appointment" CssClass="btn-primary-custom" OnClick="btnBook_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAppModal() { document.getElementById('modalApp').classList.add('active'); }
        function closeAppModal() { document.getElementById('modalApp').classList.remove('active'); }
    </script>

</asp:Content>
