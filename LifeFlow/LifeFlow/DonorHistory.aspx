<%@ Page Title="Donation History" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonorHistory.aspx.cs" Inherits="LifeFlow.DonorHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        table th { background-color: #f9f9f9; }
        .btn-donate { background: #8b0000; color: #fff; padding: 8px 15px; border-radius: 4px; text-decoration: none; float: right; margin-bottom: 15px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="DonorContent" runat="server">
    <div class="table-container">
        <h2>My Donation History <a href="DonateBlood.aspx" class="btn-donate">Donate Now</a></h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Location/Camp</th>
                    <th>Units Donated</th>
                    <th>Certificate</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>12-Aug-2026</td>
                    <td>City Civil Hospital</td>
                    <td>1</td>
                    <td><a href="#">Download</a></td>
                </tr>
                <tr>
                    <td>05-Mar-2026</td>
                    <td>Mega Blood Camp, Surat</td>
                    <td>1</td>
                    <td><a href="#">Download</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
