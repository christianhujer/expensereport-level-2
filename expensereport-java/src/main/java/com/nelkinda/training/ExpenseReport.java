package com.nelkinda.training;

import java.util.Date;
import java.util.List;

enum ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    ExpenseType type;
    int amount;
}

public class ExpenseReport {
    public void printReport(List<Expense> expenses, boolean htmlMode) {
        int total = 0;
        int mealExpenses = 0;

        if (htmlMode) {
            System.out.println("<!DOCTYPE html>");
            System.out.println("<html lang=\"en\">");
            System.out.println("<head>");
            System.out.println("<title>Expenses " + new Date() + "</title>");
            System.out.println("</head>");
            System.out.println("<body>");
            System.out.println("<h1>Expenses " + new Date() + "</h1>");
        } else {
            System.out.println("Expenses " + new Date());
        }

        if (htmlMode) {
            System.out.println("<table>");
            System.out.println("<thead>");
            System.out.println("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>");
            System.out.println("</thead>");
            System.out.println("<tbody>");
        }
        for (Expense expense : expenses) {
            if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount;
            }

            String expenseName = "";
            switch (expense.type) {
            case DINNER:
                expenseName = "Dinner";
                break;
            case BREAKFAST:
                expenseName = "Breakfast";
                break;
            case CAR_RENTAL:
                expenseName = "Car Rental";
                break;
            }

            String mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " ";

            if (htmlMode) {
                System.out.println("<tr><td>" + expenseName + "</td><td>" + expense.amount + "</td><td>" + mealOverExpensesMarker + "</td></tr>");
            } else {
                System.out.println(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker);
            }

            total += expense.amount;
        }
        if (htmlMode) {
            System.out.println("</tbody>");
            System.out.println("</table>");
        }

        if (htmlMode) {
            System.out.println("<p>Meal expenses: " + mealExpenses + "</p>");
            System.out.println("<p>Total expenses: " + mealExpenses + "</p>");
        } else {
            System.out.println("Meal expenses: " + mealExpenses);
            System.out.println("Total expenses: " + total);
        }

        if (htmlMode) {
            System.out.println("</body>");
            System.out.println("</html>");
        }
    }
}
