using System;
using System.Collections.Generic;

namespace expensereport_csharp
{
    public enum ExpenseType
    {
        DINNER, BREAKFAST, CAR_RENTAL
    }

    public class Expense
    {
        public ExpenseType type;
        public int amount;
    }

    public class ExpenseReport
    {
        public void PrintReport(List<Expense> expenses, bool htmlMode)
        {
            int total = 0;
            int mealExpenses = 0;

            if (htmlMode)
            {
                Console.WriteLine("<!DOCTYPE html>");
                Console.WriteLine("<html lang=\"en\">");
                Console.WriteLine("<head>");
                Console.WriteLine("<title>Expenses " + DateTime.Now + "</title>");
                Console.WriteLine("</head>");
                Console.WriteLine("<body>");
                Console.WriteLine("<h1>Expenses " + DateTime.Now + "</h1>");
            }
            else
            {
                Console.WriteLine("Expenses " + DateTime.Now);
            }

            if (htmlMode)
            {
                Console.WriteLine("<table>");
                Console.WriteLine("<thead>");
                Console.WriteLine("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>");
                Console.WriteLine("</thead>");
                Console.WriteLine("<tbody>");
            }
            foreach (Expense expense in expenses)
            {
                if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST)
                {
                    mealExpenses += expense.amount;
                }

                String expenseName = "";
                switch (expense.type)
                {
                    case ExpenseType.DINNER:
                        expenseName = "Dinner";
                        break;
                    case ExpenseType.BREAKFAST:
                        expenseName = "Breakfast";
                        break;
                    case ExpenseType.CAR_RENTAL:
                        expenseName = "Car Rental";
                        break;
                }

                String mealOverExpensesMarker =
                    expense.type == ExpenseType.DINNER && expense.amount > 5000 ||
                    expense.type == ExpenseType.BREAKFAST && expense.amount > 1000
                        ? "X"
                        : " ";

                if (htmlMode)
                {
                    Console.WriteLine("<tr><td>" + expenseName + "</td><td>" + expense.amount + "</td><td>" + mealOverExpensesMarker + "</td></tr>");
                }
                else
                {
                    Console.WriteLine(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker);
                }

                total += expense.amount;
            }
            if (htmlMode)
            {
                Console.WriteLine("</tbody>");
                Console.WriteLine("</table>");
            }

            if (htmlMode)
            {
                Console.WriteLine("<p>Meal expenses: " + mealExpenses + "</p>");
                Console.WriteLine("<p>Total expenses: " + total + "</p>");
            }
            else
            {
                Console.WriteLine("Meal expenses: " + mealExpenses);
                Console.WriteLine("Total expenses: " + total);
            }

            if (htmlMode)
            {
                Console.WriteLine("</body>");
                Console.WriteLine("</html>");
            }
        }
    }
}
