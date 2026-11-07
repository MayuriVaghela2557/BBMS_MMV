<%@ Page Title="Manage Blood Requests" Language="C#" MasterPageFile="~/HospitalSite.Master" AutoEventWireup="true" CodeBehind="HospitalBloodRequests.aspx.cs" Inherits="LifeFlow.HospitalBloodRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-box {
            padding: 8px 15px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            width: 250px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HospitalContent" runat="server">
    <div class="header-actions">
        <h1 class="page-title" style="margin:0;">Manage Blood Requests</h1>
        <a href="#" class="btn-primary" onclick="alert('In phase 3, this will open a modal to submit a new blood request to the admin.'); return false;">
            <i class="fa-solid fa-plus"></i> New Blood Request
        </a>
    </div>

    <div class="card">
        <div style="margin-bottom: 15px; display:flex; gap:10px;">
            <input type="text" class="search-box" placeholder="Search patient name..." />
            <select class="search-box">
                <option value="">All Statuses</option>
                <option value="Pending">Pending</option>
                <option value="Approved">Approved</option>
                <option value="Rejected">Rejected</option>
            </select>
            <button type="button" class="btn-primary" style="background:var(--text-muted);"><i class="fa-solid fa-filter"></i> Filter</button>
        </div>

        <table class="custom-table">
            <thead>
                <tr>
                    <th>Req ID</th>
                    <th>Patient Name</th>
                    <th>Blood Group</th>
                    <th>Units</th>
                    <th>Required Date</th>
                    <th>Admin Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>#REQ-1042</td>
                    <td>Rajesh Mehta</td>
                    <td><strong>B+</strong></td>
                    <td>2</td>
                    <td>25-Sep-2026</td>
                    <td><span class="badge badge-approved">Approved</span></td>
                    <td>
                        <button class="btn-primary" style="padding: 5px 10px; font-size:12px; background:#0ea5e9;">View</button>
                    </td>
                </tr>
                <tr>
                    <td>#REQ-1045</td>
                    <td>Neha Shah</td>
                    <td><strong>O-</strong></td>
                    <td>1</td>
                    <td>28-Sep-2026</td>
                    <td><span class="badge badge-pending">Pending</span></td>
                    <td>
                        <button class="btn-primary" style="padding: 5px 10px; font-size:12px; background:#0ea5e9;">View</button>
                        <button class="btn-primary" style="padding: 5px 10px; font-size:12px; background:#ef4444;">Cancel</button>
                    </td>
                </tr>
                <tr>
                    <td>#REQ-1020</td>
                    <td>Kiran Desai</td>
                    <td><strong>AB+</strong></td>
                    <td>4</td>
                    <td>15-Sep-2026</td>
                    <td><span class="badge badge-rejected">Rejected</span></td>
                    <td>
                        <button class="btn-primary" style="padding: 5px 10px; font-size:12px; background:#0ea5e9;">View</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
