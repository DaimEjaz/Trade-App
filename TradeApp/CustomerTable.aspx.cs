using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;


namespace TradeApp
{
    public partial class CustomerTable : System.Web.UI.Page
    {
        public string[] nameArr = { "Edgar Barber", "Marquis Reilly", "Isabell Frank", "Issac Hammond", "Aydan Mcclain", "Daphne Burke", "Mia Duarte", "Phoebe Mcclain", "Dayana Massey", "Maxwell Zhang" };

        public string[] addressArr = { "753, Schinner Lake", "15504, O'Kon Plaza", "10281, Moore Island", "58552, Fermin Harbors", "786, Schmitt Crescent", "4028, Swaniawski Pass", "12616, Allison Inlet", "19745, Emily Street", "5733, Winifred Motorway", "678, McClure Course" };

        public List<Customer> customerList;

        protected void Page_Load(object sender, EventArgs e)
        {
            List<Customer> customerList = new Customer().GenerateCustomerList(nameArr, addressArr, 20);

            if (Session["username"] == null && Session["password"] == null)
            {
                Response.Redirect("LoginPage.aspx");
            }

            if (Session["customerList"] == null)
            {
                //Get a list of Products and add it to data

                //using (SqlConnection sqlCon = new SqlConnection(@"Data Source=JARVIS\SQLEXPRESS;Initial Catalog=Tbl;Integrated Security=True"))
                //{
                //    Session["customersInserted"] = false;
                //    if (!Convert.ToBoolean(Session["customersInserted"]))
                //    {
                //        for (int i = 0; i < customerList.Count; i++)
                //        {
                //            Customer obj = customerList[i];
                //            string query = "INSERT INTO dbo.CustomersTbl(CustomerId, Name, Address) VALUES(@CustomerId, @Name, @Address)";
                //            using (SqlCommand command = new SqlCommand(query, sqlCon))
                //            {
                //                command.Parameters.AddWithValue("@CustomerId", obj.Id);
                //                command.Parameters.AddWithValue("@Name", obj.Name);
                //                command.Parameters.AddWithValue("@Address", obj.Address);

                //                sqlCon.Open();
                //                //int result = command.ExecuteNonQuery();
                //                sqlCon.Close();

                //            }

                //        }

                //        Session["customersInserted"] = true;
                //    }
                    
                //}

                Session["customerList"] = customerList;
            }
            //else
            //{
            //    List<Customer> customerList = (List<Customer>)Session["customerList"];

            //}
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string GetCustomerList()
        {
            List<Customer> list = HttpContext.Current.Session["customerList"] as List<Customer>;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [WebMethod]

        public static string AddCustomer(string name, string address)
        {
            List<Customer> list = HttpContext.Current.Session["customerList"] as List<Customer>;
            int index = list.Count;
            list.Add(new Customer(index + 1, name, address));
            HttpContext.Current.Session["customerList"] = list;

            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [WebMethod]

        public static string DeleteCustomer(string index)
        {
            Customer customer = new Customer();
            List<Customer> list = HttpContext.Current.Session["customerList"] as List<Customer>;
            var key = Convert.ToInt32(index);
            foreach (Customer cust in list)
            {
                if (cust.Id == key)
                {
                    customer = cust;
                }
            }
            list.Remove(customer);
            HttpContext.Current.Session["customerList"] = list;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [WebMethod]

        public static string EditCustomer(string id, string name, string address)
        {
            Customer customer = new Customer();
            List<Customer> list = HttpContext.Current.Session["customerList"] as List<Customer>;
            var key = Convert.ToInt32(id);
            foreach (Customer cust in list)
            {
                if (cust.Id == key)
                {
                    cust.Name = name;
                    cust.Address = address;
                }
            }
            HttpContext.Current.Session["customerList"] = list;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [WebMethod]

        public static double  GenerateBill(string id)
        {
            Customer customer = new Customer();
            List<Customer> list = HttpContext.Current.Session["customerList"] as List<Customer>;
            var key = Convert.ToInt32(id);
            double totalBill = 0;
            foreach (Customer cust in list)
            {
                if (cust.Id == key)
                {
                    totalBill = new Bill().CalculateBill(cust);
                }
            }
            HttpContext.Current.Session["customerList"] = list;
            return totalBill;
        }

        protected void GoToProductsPage(object sender, EventArgs e)
        {
            Response.Redirect("ProductTable.aspx");
        }

        protected void GoToCustomerPage(object sender, EventArgs e)
        {
            Response.Redirect("CustomerTable.aspx");
        }

        protected void GoToAdminPage(object sender, EventArgs e)
        {
            Response.Redirect("AdminHome.aspx");
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("LoginPage.aspx");
        }

    }
}