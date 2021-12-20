#!/usr/bin/env julia

using Dates

@enum ExpenseType begin
    BREAKFAST
    DINNER
    CAR_RENTAL
end

struct Expense
    type::ExpenseType
    amount::Int64
end


function printReport(expenses, htmlMode)
    mealExpenses = 0
    total = 0
    if htmlMode
        println("<!DOCTYPE html>")
        println("<html>")
        println("<head>")
        println("<title>Expense Report ", Dates.now(), "</title>")
        println("</head>")
        println("<body>")
        println("<h1>Expense Report ", Dates.now(), "</h1>")
    else
        println("Expense Report: ", Dates.now())
    end

    if htmlMode
        println("<table>")
        println("<thead>")
        println("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>")
        println("</thead>")
        println("<tbody>")
    end
    for expense in expenses
        if expense.type == BREAKFAST || expense.type == DINNER
            mealExpenses += expense.amount
        end
        expenseName = ""
        if expense.type == BREAKFAST
            expenseName = "Breakfast"
        elseif expense.type == DINNER
            expenseName = "Dinner"
        elseif expense.type == CAR_RENTAL
            expenseName = "Car Rental"
        end
        mealOverExpensesMarker = expense.type == DINNER && expense.amount > 5000 || expense.type == BREAKFAST && expense.amount > 1000 ? "X" : " "
        if htmlMode
            println("<tr><td>", expenseName, "</td><td>", expense.amount, "</td><td>", mealOverExpensesMarker, "</td></tr>")
        else
            println(expenseName, "\t", expense.amount, "\t", mealOverExpensesMarker)
        end
        total += expense.amount
    end
    if htmlMode
        println("</tbody>")
        println("</table>")
    end

    if htmlMode
        println("<p>Meal expenses: ", mealExpenses, "</p>")
        println("<p>Total expenses: ", total, "</p>")
    else
        println("Meal expenses: ", mealExpenses)
        println("Total expenses: ", total)
    end

    if htmlMode
        println("</body>")
        println("</html>")
    end
end

printReport([
    Expense(BREAKFAST, 1000),
    Expense(BREAKFAST, 1001),
    Expense(DINNER, 5000),
    Expense(DINNER, 5001),
    Expense(CAR_RENTAL, 4),
], true)
