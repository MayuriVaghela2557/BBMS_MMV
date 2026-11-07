using System;
using System.Collections.Generic;

namespace BloodBankManagementSystem
{
    // Simple POCO models for demonstration
    public class Hospital
    {
        public int HospitalId { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string ContactNumber { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class BloodStock
    {
        public int StockId { get; set; }
        public string BloodGroup { get; set; }
        public int Units { get; set; }
        public DateTime UpdatedOn { get; set; }
    }

    public class BloodRequest
    {
        public int RequestId { get; set; }
        public string RequestedBy { get; set; }
        public string BloodGroup { get; set; }
        public int Units { get; set; }
        public string Status { get; set; } // Pending, Approved, Rejected
        public DateTime RequestDate { get; set; }
    }

    public class DonationRecord
    {
        public int DonationId { get; set; }
        public string DonorName { get; set; }
        public string BloodGroup { get; set; }
        public int Units { get; set; }
        public DateTime DonationDate { get; set; }
        public bool Verified { get; set; }
    }
}
