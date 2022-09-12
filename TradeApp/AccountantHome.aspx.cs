using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TradeApp
{
    public partial class AccountantHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // check Session state if it is null redirect it to LogIn

            if (Session["username"] == null && Session["password"] == null)
            {
                Response.Redirect("LoginPage.aspx");
            }
            else
            {
                greeting.InnerText = "Hello there, Mr. " + Session["username"];

            }

        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("LoginPage.aspx");
        }

        

        protected void GoToProductsPage(object sender, EventArgs e)
        {
            Response.Redirect("ProductTable.aspx");
        }

        protected void GoToCustomerPage(object sender, EventArgs e)
        {
            Response.Redirect("CustomerTable.aspx");
        }

        protected void GoToHome(object sender, EventArgs e)
        {
            Response.Redirect("AccountantHome.aspx");
        }

    }
}