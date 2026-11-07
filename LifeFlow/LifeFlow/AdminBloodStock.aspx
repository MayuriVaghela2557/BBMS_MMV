<%@ Page Title="Blood Stock" Language="C#" MasterPageFile="~/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminBloodStock.aspx.cs" Inherits="LifeFlow.AdminBloodStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stock-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stock-group-card {
            background: #ffffff;
            padding: 22px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .stock-group-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
        }
        .stock-blood-badge {
            width: 58px;
            height: 58px;
            border-radius: 50%;
            background: #fee2e2;
            color: #dc2626;
            margin: 0 auto 12px auto;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 800;
            font-family: 'Poppins', sans-serif;
            box-shadow: 0 4px 10px rgba(220,38,38,0.15);
        }
        .stock-group-card h3 {
            margin: 0 0 4px 0;
            font-size: 26px;
            font-weight: 700;
            color: #1e293b;
        }
        .stock-group-card p {
            margin: 0 0 14px 0;
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }
        .stock-status-pill {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 14px;
        }
        .stock-safe { background: #dcfce7; color: #15803d; }
        .stock-medium { background: #fef3c7; color: #b45309; }
        .stock-critical { background: #fee2e2; color: #dc2626; }
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
        <h3 class="section-title"><i class="fa-solid fa-boxes-stacked text-primary"></i> Blood Stock Inventory</h3>
        <button type="button" class="btn-primary-custom" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);" onclick="openUpdateStockModal()">
            <i class="fa-solid fa-plus"></i> Update / Add Stock
        </button>
    </div>

    <!-- Alert Messages -->
    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>

    <!-- Stock Summary Cards Grid -->
    <div class="stock-cards-grid">
        <asp:Repeater ID="rptStockCards" runat="server">
            <ItemTemplate>
                <div class="stock-group-card">
                    <div class="stock-blood-badge"><%# Eval("BloodGroup") %></div>
                    <h3><%# Eval("UnitsAvailable") %></h3>
                    <p>Available Units</p>
                    <span class="stock-status-pill stock-safe">Stock Available</span>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Stock Table Container -->
    <div class="table-card">
        <div class="section-header">
            <h3 class="section-title"><i class="fa-solid fa-list"></i> Detailed Blood Stock Table</h3>
        </div>
        <div class="table-responsive-wrapper">
            <asp:GridView ID="GridView1" runat="server" CssClass="custom-table" AutoGenerateColumns="False" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Stock ID">
                        <ItemTemplate>
                            <asp:Label ID="lblStockId" runat="server" Text='<%# "#STK-" + Eval("StockId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Blood Group">
                        <ItemTemplate>
                            <span class="badge-pill badge-blood-tag" style="font-size:14px; padding:6px 14px;"><%# Eval("BloodGroup") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Units Available">
                        <ItemTemplate>
                            <strong style="font-size:16px;"><asp:Label ID="lblUnits" runat="server" Text='<%# Eval("UnitsAvailable") + " Units" %>'></asp:Label></strong>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stock Condition">
                        <ItemTemplate>
                            <span class="stock-status-pill stock-safe"><%# Eval("UnitsAvailable") %> Units</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Updated">
                        <ItemTemplate>
                            <asp:Label ID="lblUpdated" runat="server" Text='<%# Eval("LastUpdated") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-placeholder">
                        <i class="fa-solid fa-boxes-stacked"></i>
                        <p style="margin:0; font-weight:500;">No blood stock found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- ================= UPDATE / ADD STOCK MODAL FORM ================= -->
    <div class="modal-backdrop-custom" id="modalUpdateStock">
        <div class="modal-card">
            <div class="modal-card-header" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                <h4><i class="fa-solid fa-box-archive"></i> Add / Update Blood Stock Units</h4>
                <button type="button" class="modal-close-btn" onclick="closeUpdateStockModal()">&times;</button>
            </div>
            
            <div class="modal-card-body">
                <div class="grid-form">
                    <div class="form-field-group">
                        <label>Blood Group <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlStockBloodGroup" runat="server">
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
                        <label>Action Mode <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlStockMode" runat="server">
                            <asp:ListItem Value="Add">Add Units to Existing Stock (+)</asp:ListItem>
                            <asp:ListItem Value="Set">Set Exact Total Units (=)</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group full-width">
                        <label>Units Quantity <span class="req">*</span></label>
                        <asp:TextBox ID="txtStockUnits" runat="server" TextMode="Number" Text="10" min="1" max="1000"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="modal-card-footer">
                <button type="button" class="btn-secondary-custom" onclick="closeUpdateStockModal()">Cancel</button>
                <asp:Button ID="btnSaveStock" runat="server" Text="Update Inventory" CssClass="btn-primary-custom" Style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);" OnClick="btnSaveStock_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openUpdateStockModal() {
            document.getElementById('modalUpdateStock').classList.add('active');
        }
        function closeUpdateStockModal() {
            document.getElementById('modalUpdateStock').classList.remove('active');
        }
    </script>

</asp:Content>
