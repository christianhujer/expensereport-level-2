#!/usr/bin/rakudo

use v6;

enum ExpenseType <DINNER BREAKFAST CAR_RENTAL>;

class Expense {
    has ExpenseType $.type;
    has Int $.amount;
}

sub printReport($html_mode, *@expenses) {
    my $mealExpenses = 0;
    my $total = 0;
    my $datestring = DateTime.now();

    if ($html_mode) {
        print qq:to/END/;
            <!DOCTYPE html>
            <html lang="en">
            <head>
            <title>Expense Report: {$datestring}</title>
            </head>
            <body>
            <h1>Expense Report: {$datestring}</h1>
            END
    } else {
        print "Expense Report: $datestring\n";
    }

    if ($html_mode) {
        print qq:to/END/;
            <table>
            <thead>
            <tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
            </thead>
            <tbody>
            END
    }
    for @expenses -> $expense {
        if ($expense.type == DINNER || $expense.type == BREAKFAST) {
            $mealExpenses += $expense.amount;
        }
        my $expenseName = "";
        given $expense.type {
            when DINNER { $expenseName = "Dinner"; }
            when BREAKFAST { $expenseName = "Breakfast"; }
            when CAR_RENTAL { $expenseName = "Car Rental"; }
        }
        my $amount = $expense.amount;
        my $mealOverExpensesMarker = $expense.type == DINNER && $expense.amount > 5000 || $expense.type == BREAKFAST && $expense.amount > 1000 ?? "X" !! " ";
        if ($html_mode) {
            print "<tr><td>{$expenseName}</td><td>{$amount}</td><td>{$mealOverExpensesMarker}</td></tr>\n";
        } else {
            print "$expenseName\t$amount\t$mealOverExpensesMarker\n";
        }
        $total += $expense.amount;
    }
    if ($html_mode) {
        print qq:to/END/;
            </tbody>
            </table>
            END
    }

    if ($html_mode) {
        print "<p>Meal Expenses: {$mealExpenses}</p>\n";
        print "<p>Total Expenses: {$total}</p>\n";
    } else {
        print "Meal Expenses: $mealExpenses\n";
        print "Total Expenses: $total\n";
    }

    if ($html_mode) {
        print qq:to/END/;
            </body>
            </html>
            END
    }
}

printReport(1, Expense.new(type => BREAKFAST, amount => 1000), Expense.new(type => BREAKFAST, amount => 1001), Expense.new(type => DINNER, amount => 5000), Expense.new(type => DINNER, amount => 5001), Expense.new(type => CAR_RENTAL, amount => 4));
