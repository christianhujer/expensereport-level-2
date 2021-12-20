#!/usr/bin/groovy

enum ExpenseType {
    DINNER,
    BREAKFAST,
    CAR_RENTAL,
}

class Expense {
    ExpenseType type;
    int amount;
}

def printReport(boolean htmlMode, Expense... expenses) {
    int total = 0;
    int mealExpenses = 0;

    if (htmlMode) {
        println "<!DOCTYPE html>";
        println "<html lang=\"en\">";
        println "<head>";
        println "<title>Expenses ${new java.util.Date()}</title>";
        println "</head>";
        println "<body>";
        println "<h1>Expenses ${new java.util.Date()}</h1>";
    } else {
        println "Expenses: ${new java.util.Date()}";
    }

    if (htmlMode) {
        println "<table>";
        println "<thead>";
        println "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>";
        println "</thead>";
        println "<tbody>";
    }
    for (Expense expense in expenses) {
        if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
            mealExpenses += expense.amount;
        }
        String expenseName = "";
        switch (expense.type) {
        case ExpenseType.DINNER: expenseName = "Dinner"; break;
        case ExpenseType.BREAKFAST: expenseName = "Breakfast"; break;
        case ExpenseType.CAR_RENTAL: expenseName = "Car Rental"; break;
        }
        String mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " ";
        println "$expenseName\t$expense.amount\t$mealOverExpensesMarker";
        total += expense.amount;
    }
    if (htmlMode) {
        println "</tbody>";
        println "</table>";
    }

    if (htmlMode) {
        println "<p>Meal Expenses: $mealExpenses</p>";
        println "<p>Total Expenses: $total</p>";
    } else {
        println "Meal Expenses: $mealExpenses";
        println "Total Expenses: $total";
    }

    if (htmlMode) {
        println "</body>";
        println "</html>";
    }
}
