package org.nelkinda.training

import java.util.*

enum class ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    var type: ExpenseType? = null
    var amount: Int? = null
}

class ExpenseReport {
    fun printReport(expenses: List<Expense>, htmlMode: Boolean) {
        var total = 0
        var mealExpenses = 0

        if (htmlMode) {
            println("<!DOCTYPE html>")
            println("<html>")
            println("<head>")
            println("<title>Expenses " + Date() + "</title>")
            println("</head>")
            println("<body>")
            println("<h1>Expenses " + Date() + "</h1>")
        } else {
            println("Expenses " + Date())
        }

        if (htmlMode) {
            println("<table>")
            println("<thead>")
            println("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>")
            println("</thead>")
            println("<tbody>")
        }
        for (expense in expenses) {
            if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount!!
            }

            var expenseName = ""
            when (expense.type) {
                ExpenseType.DINNER -> expenseName  = "Dinner"
                ExpenseType.BREAKFAST -> expenseName = "Breakfast"
                ExpenseType.CAR_RENTAL -> expenseName = "Car Rental"
            }

            val mealOverExpensesMarker = if (expense.type == ExpenseType.DINNER && expense.amount!! > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount!! > 1000) "X" else " "

            if (htmlMode) {
                println("<tr><td>" + expenseName + "</td><td>" + expense.amount + "</td><td>" + mealOverExpensesMarker + "</td></tr>")
            } else {
                println(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)
            }

            total += expense.amount!!
        }
        if (htmlMode) {
            println("</tbody>")
            println("</table>")
        }

        if (htmlMode) {
            println("<p>Meal expenses: " + mealExpenses + "</p>")
            println("<p>Total expenses: " + mealExpenses + "</p>")
        } else {
            println("Meal expenses: $mealExpenses")
            println("Total expenses: $total")
        }

        if (htmlMode) {
            println("</body>")
            println("</html>")
        }
    }
}
