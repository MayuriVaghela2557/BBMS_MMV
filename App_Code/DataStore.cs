using System;
using System.Collections.Generic;

namespace BloodBankManagementSystem
{
    // Simple in‑memory data store for demo purposes.
    public static class DataStore
    {
        static DataStore()
        {
            // Seed with a sample hospital so login works.
            Hospitals = new List<Hospital>
            {
                new Hospital
                {
                    HospitalId = 1,
                    Name = "Demo Hospital",
                    Address = "123 Main St",
                    ContactNumber = "0123456789",
                    Email = "demo@hospital.com",
                    Username = "admin",
                    Password = "admin"
                }
            };
            Stock = new List<BloodStock>();
            Requests = new List<BloodRequest>();
            Donations = new List<DonationRecord>();
        }

        public static List<Hospital> Hospitals { get; set; }
        public static List<BloodStock> Stock { get; set; }
        public static List<BloodRequest> Requests { get; set; }
        public static List<DonationRecord> Donations { get; set; }
    }
}
