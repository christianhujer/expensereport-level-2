#!/usr/bin/tclsh

set ExpenseType { DINNER BREAKFAST CAR_RENTAL }

::oo::class create Expense {
    variable Type
    variable Amount

    constructor {type amount} {
        set Type $type
        set Amount $amount
    }

    method amount {} {
        return $Amount
    }

    method type {} {
        return $Type
    }
}

proc printExpenses { html_mode args } {
    set expenses $args
    set total 0
    set mealExpenses 0
    set now [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]
    if {$html_mode} {
        puts "<!DOCTYPE html>
<html lang=\"en\">
<head>
<title>Expense Report: $now</title>
</head>
<body>
<h1>Expense Report: $now</h1>"
    } else {
        puts "Expense Report: $now"
    }

    if {$html_mode} {
        puts "<table>
<thead>
<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>
</thead>
<tbody>"
    }
    foreach expense $expenses {
        if {[$expense type] == {DINNER} || [$expense type] == {BREAKFAST}} {
            set mealExpenses [expr { $mealExpenses + [$expense amount]}]
        }
        set expenseName ""
        switch [$expense type] {
            DINNER { set expenseName "Dinner" }
            BREAKFAST { set expenseName "Breakfast" }
            CAR_RENTAL { set expenseName "Car Rental" }
        }
        if {[$expense type] == {DINNER} && [$expense amount] > 5000 || [$expense type] == {BREAKFAST} && [$expense amount] > 1000} {
            set mealOverExpensesMarker "X"
        } else {
            set mealOverExpensesMarker " "
        }
        set amount [$expense amount]
        if {$html_mode} {
            puts "<tr><td>$expenseName</td><td>$amount</td><td>$mealOverExpensesMarker</td></tr>"
        } else {
            puts "$expenseName\t$amount\t$mealOverExpensesMarker"
        }
        set total [expr { $total + [$expense amount]}]
    }
    if {$html_mode} {
        puts "</tbody>"
        puts "</table>"
    }

    if {$html_mode} {
        puts "<p>Meal Expenses: $mealExpenses</p>"
        puts "<p>Total Expenses: $total</p>"
    } else {
        puts "Meal Expenses: $mealExpenses"
        puts "Total Expenses: $total"
    }

    if {$html_mode} {
        puts "</body>"
        puts "</html>"
    }
}

printExpenses 1 [Expense new BREAKFAST 1000] [Expense new BREAKFAST 1001] [Expense new DINNER 5000] [Expense new DINNER 5001] [Expense new CAR_RENTAL 4]
