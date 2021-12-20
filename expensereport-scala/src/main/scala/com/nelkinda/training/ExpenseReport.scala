package com.nelkinda.training

import java.util.Date

class ExpenseType {
}

object ExpenseType {
    val DINNER = new ExpenseType()
    val BREAKFAST = new ExpenseType()
    val CAR_RENTAL = new ExpenseType()
}

class Expense(val `type`: ExpenseType, val amount: Int)


class ExpenseReport {
    def printReport(htmlMode: Boolean, expenses: List[Expense]) {
        var totalExpenses = 0
        var mealExpenses = 0
        if (htmlMode) {
            println("""<!DOCTYPE html>
                    |<html>
                    |<head>
                    |<title>Expense Report: ${new Date()}</title>
                    |</head>
                    |<body>
                    |<h1>Expense Report: ${new Date()}</h1>""".stripMargin)
        } else {
            println(s"Expense Report: ${new Date()}")
        }

        if (htmlMode) {
            println("""<table>
                    |<thead>
                    |<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
                    |</thead>
                    |<tbody>""".stripMargin)
        }
        for (expense <- expenses) {
            if (expense.`type` == ExpenseType.DINNER || expense.`type` == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount
            }
            var expenseName = expense.`type` match {
                case ExpenseType.DINNER => "Dinner"
                case ExpenseType.BREAKFAST => "Breakfast"
                case ExpenseType.CAR_RENTAL => "Car Rental"
            }
            var mealOverExpensesMarker = if (expense.`type` == ExpenseType.DINNER && expense.amount > 5000 || expense.`type` == ExpenseType.BREAKFAST && expense.amount > 1000) "X" else " "
            if (htmlMode) {
                println(s"<tr><td>${expenseName}</td><td>${expense.amount}</td><td>${mealOverExpensesMarker}</td></tr>")
            } else {
                println(s"${expenseName}\t${expense.amount}\t${mealOverExpensesMarker}")
            }
            totalExpenses += expense.amount
        }
        if (htmlMode) {
            println(s"</tbody>");
            println(s"</table>");
        }

        if (htmlMode) {
            println(s"<p>Meal Expenses: ${mealExpenses}</p>")
            println(s"<p>Total Expenses: ${totalExpenses}</p>")
        } else {
            println(s"Meal Expenses: ${mealExpenses}")
            println(s"Total Expenses: ${totalExpenses}")
        }

        if (htmlMode) {
            println(s"</body>");
            println(s"</html>");
        }
    }
}

object Main {
    def main(args: Array[String]) {
        new ExpenseReport().printReport(true, List[Expense](
            new Expense(ExpenseType.BREAKFAST, 1000),
            new Expense(ExpenseType.BREAKFAST, 1001),
            new Expense(ExpenseType.DINNER, 5000),
            new Expense(ExpenseType.DINNER, 5001),
            new Expense(ExpenseType.CAR_RENTAL, 4),
        ))
    }
}
