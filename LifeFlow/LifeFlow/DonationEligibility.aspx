<%@ Page Title="Donation Eligibility" Language="C#" MasterPageFile="~/DonorSite.Master" AutoEventWireup="true" CodeBehind="DonationEligibility.aspx.cs" Inherits="LifeFlow.DonationEligibility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .eligibility-checklist-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 24px;
            border: 1px solid #ffe4e6;
            margin-bottom: 25px;
        }
        .elig-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            padding: 14px 0;
            border-bottom: 1px solid #fff1f2;
        }
        .elig-item:last-child { border-bottom: none; }
        .elig-icon-box {
            width: 36px; height: 36px; border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 16px; flex-shrink: 0;
        }
        .elig-yes { background: #dcfce7; color: #16a34a; }
        .elig-no { background: #fee2e2; color: #e11d48; }
        .elig-info h4 { margin: 0 0 4px 0; font-size: 14px; font-weight: 600; color: #4c0519; }
        .elig-info p { margin: 0; font-size: 12.5px; color: #64748b; }
        .disclaimer-box {
            background: #fff1f2;
            border-left: 4px solid #e11d48;
            padding: 14px 18px;
            border-radius: 8px;
            font-size: 13px;
            color: #881337;
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="DonorMainContent" runat="server">

    <div class="section-header">
        <h3 class="section-title"><i class="fa-solid fa-clipboard-check" style="color:#e11d48;"></i> Blood Donation Eligibility Guidelines</h3>
        <a href="DonationAppointment.aspx" class="btn-primary-custom">
            <i class="fa-solid fa-calendar-plus"></i> Book Donation Now
        </a>
    </div>

    <!-- Eligibility Self-Check Card -->
    <div class="eligibility-checklist-card">
        <h4 style="margin: 0 0 16px 0; font-size: 16px; font-weight: 700; color: #4c0519; font-family: 'Poppins', sans-serif;"><i class="fa-solid fa-circle-check" style="color:#16a34a;"></i> Basic Donor Screening Criteria</h4>

        <div class="elig-item">
            <div class="elig-icon-box elig-yes"><i class="fa-solid fa-check"></i></div>
            <div class="elig-info">
                <h4>Age Requirement</h4>
                <p>Donor must be between 18 and 65 years of age.</p>
            </div>
        </div>

        <div class="elig-item">
            <div class="elig-icon-box elig-yes"><i class="fa-solid fa-check"></i></div>
            <div class="elig-info">
                <h4>Weight Criteria</h4>
                <p>Minimum weight of 45 kg or above for whole blood donation (50 kg recommended).</p>
            </div>
        </div>

        <div class="elig-item">
            <div class="elig-icon-box elig-yes"><i class="fa-solid fa-check"></i></div>
            <div class="elig-info">
                <h4>Hemoglobin Level</h4>
                <p>Hemoglobin level should be at least 12.5 g/dL (tested on-site prior to donation).</p>
            </div>
        </div>

        <div class="elig-item">
            <div class="elig-icon-box elig-yes"><i class="fa-solid fa-check"></i></div>
            <div class="elig-info">
                <h4>Donation Interval</h4>
                <p>At least 90 days (3 months) gap since your last whole blood donation for males, 120 days for females.</p>
            </div>
        </div>

        <div class="elig-item">
            <div class="elig-icon-box elig-no"><i class="fa-solid fa-xmark"></i></div>
            <div class="elig-info">
                <h4>Temporary Deferrals</h4>
                <p>Do not donate if you currently have a fever, flu, cold, dental extraction within 3 days, tattoo or piercing within past 6 months, or ongoing antibiotic treatment.</p>
            </div>
        </div>

        <div class="disclaimer-box">
            <i class="fa-solid fa-triangle-exclamation" style="color:#e11d48; margin-right:6px;"></i>
            <strong>Important Medical Disclaimer:</strong> This checklist provides basic screening guidance. Final donor eligibility is strictly evaluated and approved by authorized medical officers on-site before every blood donation.
        </div>
    </div>

</asp:Content>
