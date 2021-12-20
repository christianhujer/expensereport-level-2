#!/usr/bin/perl

package Expense;

use constant {
    DINNER => 1,
    BREAKFAST => 2,
    CAR_RENTAL => 3,
};

sub new {
    my $class = shift;
    my $self = {
        'type' => shift,
        'amount' => shift
    };
    bless $self, $class;
    return $self;
}

sub printReport($@) {
    my $html_mode = shift;
    my @expenses = @_;
    my $mealExpenses = 0;
    my $total = 0;
    my $datestring = localtime();
    if ($html_mode) {
        print <<END
<!DOCTYPE html>
<html lang="en">
<head>
<title>Expense Report: $datestring</title>
</head>
<body>
<h1>Expense Report: $datestring</h1>
END
    } else {
        print "Expense Report: $datestring\n";
    }

    if ($html_mode) {
        print <<END
<table>
<thead>
<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
</thead>
<tbody>
END
    }
    for my $expense (@expenses) {
        if ($expense->{'type'} == DINNER or $expense->{'type'} == BREAKFAST) {
            $mealExpenses += $expense->{'amount'};
        }

        my $expenseName = "";
        if ($expense->{'type'} == DINNER) {
            $expenseName = "Dinner";
        } elsif ($expense->{'type'} == BREAKFAST) {
            $expenseName = "Breakfast";
        } elsif ($expense->{'type'} == CAR_RENTAL) {
            $expenseName = "Car Rental";
        }

        my $mealOverExpensesMarker = $expense->{'type'} == DINNER && $expense->{'amount'} > 5000 || $expense->{'type'} == BREAKFAST && $expense->{'amount'} > 1000 ? "X" : " ";

        if ($html_mode) {
            print "<tr><td>$expenseName</td><td>".$expense->{'amount'}."</td><td>$mealOverExpensesMarker</td></tr>\n";
        } else {
            print "$expenseName\t".$expense->{'amount'}."\t$mealOverExpensesMarker\n";
        }
        $total += $expense->{'amount'};
    }
    if ($html_mode) {
        print "</tbody>\n";
        print "</table>\n";
    }

    if ($html_mode) {
        print "<p>Meal Expenses: $mealExpenses</p>\n";
        print "<p>Total Expenses: $total</p>\n";
    } else {
        print "Meal Expenses: $mealExpenses\n";
        print "Total Expenses: $total\n";
    }

    if ($html_mode) {
        print "</body>\n";
        print "</html>\n";
    }
}

printReport(1, new Expense(BREAKFAST, 1000), new Expense(BREAKFAST, 1001), new Expense(DINNER, 5000),new Expense(DINNER, 5001),  new Expense(CAR_RENTAL, 4));
