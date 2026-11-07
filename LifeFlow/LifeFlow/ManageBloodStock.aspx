<%@ Page Title="Manage Blood Stock" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="ManageBloodStock.aspx.cs" Inherits="LifeFlow.ManageBloodStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stock-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 18px;
            margin-bottom: 28px;
        }
        .stock-group-card {
            background: #fff;
            padding: 20px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
            border: 1px solid #e6faf7;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            position: relative;
        }
        .stock-group-card:hover { transform: translateY(-4px); box-shadow: 0 8px 18px rgba(0,0,0,0.08); }
        .stock-blood-badge {
            width: 56px; height: 56px; border-radius: 50%;
            background: #fee2e2; color: #dc2626;
            margin: 0 auto 12px auto;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; font-weight: 800;
            font-family: 'Poppins', sans-serif;
            box-shadow: 0 4px 10px rgba(220,38,38,0.15);
        }
        .stock-group-card h3 { margin: 0 0 4px 0; font-size: 26px; font-weight: 700; color: #134e4a; }
        .stock-group-card p { margin: 0 0 12px 0; font-size: 13px; color: #64748b; font-weight: 500; }
        .stock-pill { padding: 4px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; display: inline-block; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-boxes-stacked" style="color:#0d9488;"></i> Manage Blood Stock</h3>
        <button type="button" class="btn-primary-custom" onclick="openStockModal()">
            <i class="fa-solid fa-plus"></i> Update / Add Stock
        </button>
    </div>

    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Stock Summary Cards -->
    <div class="stock-cards-grid">
        <asp:Repeater ID="rptStockCards" runat="server">
            <ItemTemplate>
                <div class="stock-group-card">
                    <div class="stock-blood-badge"><%# Eval("BloodGroup") %></div>
                    <h3><%# Eval("UnitsAvailable") %></h3>
                    <p>Available Units</p>
                    <span class="stock-pill badge-stock-safe">Available</span>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Stock Table -->
    <div class="table-card">
        <div class="section-header">
            <h3 class="section-title"><i class="fa-solid fa-list" style="color:#0d9488;"></i> Blood Stock Details</h3>
        </div>
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Stock ID">
                        <ItemTemplate><asp:Label ID="lblStockId" runat="server" Text='<%# "#STK-" + Eval("StockId") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate><span class="badge-pill badge-blood-tag" style="font-size:14px; padding:6px 14px;"><%# Eval("BloodGroup") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Available">
                        <ItemTemplate><strong style="font-size:15px;"><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("UnitsAvailable") + " Units" %>'></asp:Label></strong></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stock Level">
                        <ItemTemplate>
                            <span class='stock-pill <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "badge-stock-safe" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "badge-stock-medium" : "badge-stock-critical" %>'>
                                <%# Convert.ToInt32(Eval("UnitsAvailable")) >= 50 ? "Safe" : Convert.ToInt32(Eval("UnitsAvailable")) >= 20 ? "Medium" : "Critical" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Updated">
                        <ItemTemplate><asp:Label ID="lblUpdated" runat="server" Text='<%# Eval("LastUpdated") %>'></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="actions-cell" ItemStyle-CssClass="actions-cell">
                        <ItemTemplate>
                            <div class="actions-flex">
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditStock" CommandArgument='<%# Eval("StockId") %>' CssClass="btn-icon-action btn-edit-act" ToolTip="Edit Stock">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteStock" CommandArgument='<%# Eval("StockId") %>' CssClass="btn-icon-action btn-delete-act" OnClientClick="return confirm('Delete this stock entry?');" ToolTip="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-boxes-stacked"></i>
                        <p style="margin:0; font-weight:500;">No blood stock records found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Add/Update Stock Modal -->
    <div class="modal-backdrop-custom" id="modalStock">
        <div class="modal-card">
            <div class="modal-card-header">
                <h4><i class="fa-solid fa-boxes-stacked"></i> Update / Add Blood Stock</h4>
                <button type="button" class="modal-close-btn" onclick="closeStockModal()">&times;</button>
            </div>
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Blood Group <span class="req">*</span></label>
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
                        <label>Units Available <span class="req">*</span></label>
                        <asp:TextBox ID="txtUnits" runat="server" TextMode="Number" Placeholder="e.g. 50"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Collection Date</label>
                        <asp:TextBox ID="txtCollectionDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-field-group">
                        <label>Expiry Date</label>
                        <asp:TextBox ID="txtExpiryDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-field-group full-width">
                        <label>Remarks / Notes</label>
                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="2" Placeholder="Optional notes..."></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeStockModal()">Cancel</button>
                <asp:Button ID="btnSaveStock" runat="server" Text="Save Stock" CssClass="btn-primary-custom" OnClick="btnSaveStock_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openStockModal() { document.getElementById('modalStock').classList.add('active'); }
        function closeStockModal() { document.getElementById('modalStock').classList.remove('active'); }
    </script>

</asp:Content>
