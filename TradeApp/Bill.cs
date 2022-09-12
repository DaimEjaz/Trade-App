using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeApp
{
    public class Bill
    {
        public int ID { get; set; }
        public DateTime BillGenerationTime { get; set; }

        public double TotalBill { get; set; }

        public List<Bill> BillsList { get; set; }


        public Bill()
        {


        }

        public double CalculateBill(Customer customer)
        {
            double totalBill = 0;


            for (int i = 0; i < customer.ProductsPurchased.Count; i++)
            {
                Product product = customer.ProductsPurchased[i];
                totalBill += product.ProductSalePrice;
            }

            return totalBill;
        }


    }
}