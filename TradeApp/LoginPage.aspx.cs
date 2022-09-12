using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TradeApp
{
    public partial class LoginPage : System.Web.UI.Page
    {
        Member admin = new Admin(1, "Admin", "12345", true);
        Accountant accountant = new Accountant(1, "Acc1", "12345", false);

        //Issue: How to add new enteries?
        public List<Accountant> Accountants = new List<Accountant>();



        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null && Session["password"] != null)
            {
                if (Session["redirectPage"].ToString() == "Accountant")
                {
                    Response.Redirect("AccountantHome.aspx");
                }
                if (Session["redirectPage"].ToString() == "Admin")
                {
                    Response.Redirect("AdminHome.aspx");
                }
                //System.NullReferenceException: 'Object reference not set to an instance of an object.'
            }

            if (!IsPostBack)
            {
                Session["AccList"] = Accountants;

            }
        }

        protected void Login(object sender, EventArgs e)
        {
            Session["username"] = username.Text;
            Session["password"] = password.Text;

            if (dropdown.SelectedValue == "Admin")
            {
                if (Session["username"].ToString() == admin.Name && Session["password"].ToString() == admin.Password)
                {
                    string adminPage = "AdminHome.aspx";
                    Session["redirectPage"] = "Admin";
                    Response.Redirect(adminPage);
                }

            }
            else if(dropdown.SelectedValue == "Accountant")
            {
                Session["AccountantList"] = Accountants;
                Accountants.Add(accountant);
                for (int i = 0; i < Accountants.Count; i++)
                {
                    if (Session["username"].ToString() == accountant.Name && Session["password"].ToString() == accountant.Password)
                    {
                        string accPage = "AccountantHome.aspx";
                        Session["redirectPage"] = "Accountant";
                        Response.Redirect(accPage);
                    }

                }
                //Logic for choosing accountant & redirecting
            }


        }
    }

}