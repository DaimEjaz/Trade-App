using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Accountant : Member
    {
        public List<Accountant> accountants { get; set; }

        public Accountant()
        {

        }

        public Accountant(int ID, string name, string password, bool isAdmin)
        {
            Id = ID;
            Name = name;
            Password = password;
            IsAdmin = isAdmin;

        }
    }
}