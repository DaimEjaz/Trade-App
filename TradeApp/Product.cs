using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Product
    {
        //Properties
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public double ProductCost { get; set; }
        public double ProductSalePrice { get; set; }

        //Constructors

        public Product()
        {

        }
        public Product(int productId, string productName, double productCost, double productSalePrice)
        {
            ProductId = productId;
            ProductName = productName;
            ProductCost = productCost;
            ProductSalePrice = productSalePrice;
        }

        //Method for generating product list
        public List<Product> GenerateProductList(string[] productArr, int productCount)
        {
            List<Product> products = new List<Product>();
            Random rnd = new Random();

            for (int i = 0; i < productCount; i++)
            {
                //int productId = Convert.ToInt32(Convert.ToString(i + 1) + Convert.ToString(rnd.Next(0, 10)));

                int productId = Convert.ToInt32(Convert.ToString(i + 1));


                //Cost to be between 1000 & 10000 currency units
                double productCost = rnd.Next(1000, 10000);

                //Product is sold at 5% to 20% profit margin
                double productSalePrice = Math.Round((productCost + (productCost * rnd.Next(5, 20) / 100)), 2);

                products.Add(new Product(productId, productArr[i % productArr.Length], productCost, productSalePrice));
            }
            return products;
        }
    }
}