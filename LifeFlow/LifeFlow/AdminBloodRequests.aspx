<%@ Page Title="Blood Requests" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminBloodRequests.aspx.cs" Inherits="LifeFlow.AdminBloodRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .tabs-header-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 2px;
        }
        .tab-btn {
            background: none;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 600;
            color: #64748b;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .tab-btn:hover { color: #e74c3c; }
        .tab-btn.active { color: #e74c3c; border-bottom-color: #e74c3c; }
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">

    <!-- Page Top Header -->
    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-bed-pulse text-danger"></i> Patient Blood Requests</h3>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Search & Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchRequest" runat="server" Placeholder="Search by Patient name, Hospital, City, Contact..."></asp:TextBox>
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
            <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterRequests" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterRequests_Click" />
        <asp:Button ID="btnResetFilter" runat="server" Text="Reset" CssClass="btn-secondary-custom" Style="padding: 9px 16px; background:#94a3b8;" OnClick="btnResetFilter_Click" />
    </div>

    <!-- Requests Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Req ID">
                        <ItemTemplate>
                            <asp:Label ID="lblReqId" runat="server" Text='<%# "#REQ-" + Eval("RequestId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Patient Name">
                        <ItemTemplate>
                            <strong><asp:Label ID="lblPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hospital / City">
                        <ItemTemplate>
                            <asp:Label ID="lblHospital" runat="server" Text='<%# Eval("HospitalName") + ", " + Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate>
                            <span class="badge-pill badge-blood-tag"><%# Eval("BloodGroup") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Needed">
                        <ItemTemplate>
                            <strong><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("UnitsNeeded") + " Units" %>'></asp:Label></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Urgency">
                        <ItemTemplate>
                            <span class='<%# GetUrgencyBadgeClass(Eval("Urgency")) %>'><%# Eval("Urgency") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Contact">
                        <ItemTemplate>
                            <asp:Label ID="lblContact" runat="server" Text='<%# Eval("ContactPhone") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("RequestDate", "{0:dd-MM-yyyy HH:mm}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# GetStatusBadgeClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("RequestId") %>' CssClass="btn-icon-action btn-approve-act" ToolTip="Approve Request">
                                    <i class="fa-solid fa-check"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnReject" runat="server" CommandName="Reject" CommandArgument='<%# Eval("RequestId") %>' CssClass="btn-icon-action btn-reject-act" ToolTip="Reject Request">
                                    <i class="fa-solid fa-xmark"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteRequest" CommandArgument='<%# Eval("RequestId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Are you sure you want to delete this blood request?');" ToolTip="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-inbox"></i>
                        <p style="margin:0; font-weight:500;">No blood requests found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
