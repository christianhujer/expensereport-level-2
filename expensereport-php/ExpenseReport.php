<?php

abstract class ExpenseType {
    const DINNER = 1;
    const BREAKFAST = 2;
    const CAR_RENTAL = 3;
}

class Expense {
    public $type;
    public $amount;
    function __construct($type, $amount) {
        $this->type = $type;
        $this->amount = $amount;
    }
}

class ExpenseReport {
    public function print_report($htmlMode, $expenses) {
        $mealExpenses = 0;
        $total = 0;
        $date = date("Y-m-d h:i:sa");
        if ($htmlMode) {
            ?>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Expense Report <?= $date?></title>
</head>
<body>
<h1>Expense Report <?= $date?></h1>
<?php
        } else {
            print("Expense Report {$date}\n");
        }
        if ($htmlMode) {
            ?>
<table>
<thead>
<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
</thead>
<tbody>
<?php
        }
        foreach ($expenses as $expense) {
            if ($expense->type == ExpenseType::DINNER || $expense->type == ExpenseType::BREAKFAST) {
                $mealExpenses += $expense->amount;
            }
            $expenseName = "";
            switch ($expense->type) {
                case ExpenseType::DINNER: $expenseName = "Dinner"; break;
                case ExpenseType::BREAKFAST: $expenseName = "Breakfast"; break;
                case ExpenseType::CAR_RENTAL: $expenseName = "Car Rental"; break;
            }

            $mealOverExpensesMarker = $expense->type == ExpenseType::DINNER && $expense->amount > 5000 || $expense->type == ExpenseType::BREAKFAST && $expense->amount > 1000 ? "X" : " ";
            if ($htmlMode) {
                ?>
<tr><td><?= $expenseName ?></td><td><?= $expense->amount ?></td><td><?= $mealOverExpensesMarker ?></td></tr>
<?php
            } else {
                print($expenseName . "\t" . $expense->amount . "\t" . $mealOverExpensesMarker . "\n");
            }
            $total += $expense->amount;
        }
        if ($htmlMode) { ?>
</tbody>
</table>
<?php }

        if ($htmlMode) {
            ?>
<p>Meal Expenses: <?= $mealExpenses ?></p>
<p>Total Expenses: <?= $total ?></p>
<?php } else {
            print("Meal Expenses: " . $mealExpenses . "\n");
            print("Total Expenses: " . $total . "\n");
        }

        if ($htmlMode) { ?>
</body>
</html>
<?php }
    }
}

ExpenseReport::print_report(true, [
    new Expense(ExpenseType::BREAKFAST, 1000),
    new Expense(ExpenseType::BREAKFAST, 1001),
    new Expense(ExpenseType::DINNER, 5000),
    new Expense(ExpenseType::DINNER, 5001),
    new Expense(ExpenseType::CAR_RENTAL, 4),
]);
