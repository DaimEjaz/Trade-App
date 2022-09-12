using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Admin : Member
    {
        public Admin(int ID, string name, string password, bool isAdmin)
        {
            Id = ID;
            Name = name;
            Password = password;
            IsAdmin = isAdmin;
        }


    }
}