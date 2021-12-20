enum ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    ExpenseType type = ExpenseType.DINNER;
    int amount = 0;
    Expense(ExpenseType type, int amount) {
        this.type = type;
        this.amount = amount;
    }
}

class ExpenseReport {
    void printReport(List<Expense> expenses, bool htmlMode) {
        var mealExpenses = 0;
        var totalExpenses = 0;
        var date = DateTime.now();
        if (htmlMode) {
            print("<!DOCTYPE html>");
            print("<html>");
            print("<head>");
            print("<title>Expenses $date</title>");
            print("</head>");
            print("<body>");
            print("<h1>Expenses $date</h1>");
        } else {
            print('Expense Report: $date');
        }

        if (htmlMode) {
            print("<table>");
            print("<thead>");
            print("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>");
            print("</thead>");
            print("<tbody>");
        }
        for (var expense in expenses) {
            if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount;
            }
            String expenseName;
            switch (expense.type) {
                case ExpenseType.DINNER: expenseName = 'Dinner'; break;
                case ExpenseType.BREAKFAST: expenseName = 'Breakfast'; break;
                case ExpenseType.CAR_RENTAL: expenseName = 'Car Rental'; break;
            };
            var mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? 'X' : ' ';
            if (htmlMode) {
                print('<tr><td>$expenseName</td><td>${expense.amount}</td><td>$mealOverExpensesMarker</td></tr>');
            } else {
                print('$expenseName\t${expense.amount}\t$mealOverExpensesMarker');
            }
            totalExpenses += expense.amount;
        }
        if (htmlMode) {
            print("</tbody>");
            print("</table>");
        }

        if (htmlMode) {
            print('<p>Meal Expenses: $mealExpenses</p>');
            print('<p>Total Expenses: $totalExpenses</p>');
        } else {
            print('Meal Expenses: $mealExpenses');
            print('Total Expenses: $totalExpenses');
        }

        if (htmlMode) {
            print("</body>");
            print("</html>");
        }
    }
}
