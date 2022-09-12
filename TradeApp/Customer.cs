using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }

        public List<Product> ProductsPurchased;

        public List<Bill> UserBills;

        public Customer()
        {

        }
        public Customer(int id, string name, string address)
        {
            Id = id;
            Name = name;
            Address = address;
        }

        public List<Customer> GenerateCustomerList(string[] nameArr, string[] addressArr, int customerCount)
        {
            List<Customer> customers = new List<Customer>();
            Random rnd = new Random();

            for (int i = 0; i < customerCount; i++)
            {
                //int customerId = Convert.ToInt32(Convert.ToString(i + 1) + Convert.ToString(rnd.Next(0, 10)));
                int customerId = Convert.ToInt32(Convert.ToString(i + 1) );


                customers.Add(new Customer(customerId, nameArr[i % nameArr.Length], addressArr[i % addressArr.Length]));
            }
            return customers;
        }

        public List<Product> PurchaseProducts(List<Product> products)
        {
            Random rnd = new Random();

            for (int i = 0; i < rnd.Next(3, 15); i++)
            {
                ProductsPurchased.Add(products[rnd.Next(0, products.Count)]);
            }

            return ProductsPurchased;
        }
    }
}