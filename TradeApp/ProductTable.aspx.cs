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
    public partial class ProductTable : System.Web.UI.Page
    {
        //CHANGE IT!!!
        public string[] productArr = { "Chevrolet", "Honda", "Nissan", "Ford", "Fiat", "Jeep", "Volkswagen", "Volvo", "Jaguar", "Audi", "Toyota", "Land Rover", "Lexus", "Porsche", "Bugatti", "Bentley", "Rolls Royce", "BMW", "Tesla", "Mercedes- Benz" };

        public List<Product> productList;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null && Session["password"] == null)
            {
                Response.Redirect("LoginPage.aspx");
            }

            if (Session["productList"] == null)
            {
                //Session["isInserted"] = false;
                //Get a list of Products and add it to data
                List<Product> productList = new Product().GenerateProductList(productArr, 100);

                //using(SqlConnection sqlCon = new SqlConnection(@"Data Source=JARVIS\SQLEXPRESS;Initial Catalog=Tbl;Integrated Security=True"))
                //{
                //    if (!Convert.ToBoolean(Session["isInserted"]))
                //    {
                //        for (int i = 0; i < productList.Count; i++)
                //        {
                //            Product obj = productList[i];
                //            string query = "INSERT INTO dbo.ProductTable(ProductId, ProductName, ProductCost, ProductSalePrice) VALUES(@ProductId, @ProductName, @ProductCost, @ProductSalePrice)";
                //            using (SqlCommand command = new SqlCommand(query, sqlCon))
                //            {
                //                command.Parameters.AddWithValue("@ProductId", obj.ProductId);
                //                command.Parameters.AddWithValue("@ProductName", obj.ProductName);
                //                command.Parameters.AddWithValue("@ProductCost", obj.ProductCost);
                //                command.Parameters.AddWithValue("@ProductSalePrice", obj.ProductSalePrice);

                //                sqlCon.Open();
                //                //int result = command.ExecuteNonQuery();
                //                sqlCon.Close();

                //            }


                //        }

                //        Session["isInserted"] = true;
                //    }

                //}
                Session["productList"] = productList;
            }
            else
            {
                List<Product> productList = (List<Product>)Session["productList"];

            }

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string GetProductList()
        {
            List<Product> list = HttpContext.Current.Session["productList"] as List<Product>;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]

        public static string AddProduct(string name, string cost, string salePrice)
        {
            List<Product> list = HttpContext.Current.Session["productList"] as List<Product>;
            int index = list.Count;
            list.Add(new Product(index + 1, name, Convert.ToDouble(cost), Convert.ToDouble(salePrice)));
            HttpContext.Current.Session["productList"] = list;

            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]

        public static string DeleteProduct(string index)
        {
            Product product = new Product();
            List<Product> list = HttpContext.Current.Session["productList"] as List<Product>;
            var key = Convert.ToInt32(index);
            foreach (Product p in list)
            {
                if (p.ProductId == key)
                {
                    product = p;
                }
            }
            list.Remove(product);
            HttpContext.Current.Session["productList"] = list;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
        }

        [WebMethod]

        public static string EditProduct(string id, string name, string cost, string salePrice)
        {
            Product product = new Product();
            List<Product> list = HttpContext.Current.Session["productList"] as List<Product>;
            var key = Convert.ToInt32(id);
            foreach (Product pro in list)
            {
                if (pro.ProductId == key)
                {
                    pro.ProductName = name;
                    pro.ProductCost = Convert.ToDouble(cost);
                    pro.ProductSalePrice = Convert.ToDouble(salePrice);
                }
            }
            HttpContext.Current.Session["customerList"] = list;
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(list);
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