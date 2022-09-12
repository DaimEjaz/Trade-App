using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Member
    {
        //properties
        protected int Id { get; set; }
        public string Name { get; set; }

        public string Password { get; set; }

        protected bool IsAdmin { get; set; }



        public Member()
        {
            //do nothing
        }

        //Useful constructor
        public Member(int ID, string name, string password, bool isAdmin)
        {
            Id = ID;
            Name = name;
            Password = password;
            IsAdmin = isAdmin;
        }

        public void Login()
        {

        }



    }
}