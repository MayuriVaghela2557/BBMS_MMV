<%@ Page Title="Contact Messages" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminContacts.aspx.cs" Inherits="LifeFlow.AdminContacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .contact-avatar {
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
        .contact-meta { font-size: 11px; color: #64748b; }
        .badge-read { background: #dcfce7; color: #15803d; }
        .badge-unread { background: #fee2e2; color: #dc2626; }
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

    <!-- Page Header Bar -->
    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-envelope text-info"></i> Contact & Support Messages</h3>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Search & Filter Card -->
    <div class="filter-card">
        <div class="search-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <asp:TextBox ID="txtSearchContact" runat="server" Placeholder="Search by sender name, email, subject..."></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="filter-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Unread">Unread</asp:ListItem>
            <asp:ListItem Value="Read">Read</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnFilterContacts" runat="server" Text="Filter" CssClass="btn-secondary-custom" Style="padding: 9px 16px;" OnClick="btnFilterContacts_Click" />
    </div>

    <!-- Contacts Table Container -->
    <div class="table-card">
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Msg ID">
                        <ItemTemplate>
                            <asp:Label ID="lblMsgId" runat="server" Text='<%# "#MSG-" + Eval("ContactId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sender Info">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center;">
                                <div class="contact-avatar"><%# Eval("Name").ToString().Substring(0, 1).ToUpper() %></div>
                                <div>
                                    <strong><asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label></strong>
                                    <div class="contact-meta"><%# Eval("Email") %> | <%# Eval("Phone") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Subject">
                        <ItemTemplate>
                            <strong><asp:Label ID="lblSubject" runat="server" Text='<%# Eval("Subject") %>'></asp:Label></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Message Preview">
                        <ItemTemplate>
                            <div style="max-width:250px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%# Eval("Message") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Received Date">
                        <ItemTemplate>
                            <asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("SubmittedDate")).ToString("dd MMM yyyy, hh:mm tt") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge-pill <%# Eval("Status").ToString() == "Read" ? "badge-read" : "badge-unread" %>'><%# Eval("Status") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteContact" CommandArgument='<%# Eval("ContactId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Are you sure you want to delete this message?');" ToolTip="Delete Message">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-envelope"></i>
                        <p style="margin:0; font-weight:500;">No contact messages received yet.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
