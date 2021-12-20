const type = {
    BREAKFAST: 1,
    DINNER: 2,
    CAR_RENTAL: 3,
};

function printReport(expenses, htmlMode) {
    let total = 0;
    let mealExpenses = 0;
    if (htmlMode) {
        process.stdout.write("<!DOCTYPE html>\n");
        process.stdout.write("<html lang=\"en\">\n");
        process.stdout.write("<head>\n");
        process.stdout.write("<title>Expense Report " + new Date().toISOString().slice(0, 10) + "</title>\n");
        process.stdout.write("</head>\n");
        process.stdout.write("<body>\n");
        process.stdout.write("<h1>Expense Report " + new Date().toISOString().slice(0, 10) + "</h1>\n");
    } else {
        process.stdout.write("Expenses " + new Date().toISOString().slice(0, 10) + "\n");
    }

    if (htmlMode) {
        process.stdout.write("<table>\n");
        process.stdout.write("<thead>\n");
        process.stdout.write("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>\n");
        process.stdout.write("</thead>\n");
        process.stdout.write("<tbody>\n");
    }

    for (const expense of expenses) {
        if (expense.type == type.DINNER || expense.type == type.BREAKFAST) {
            mealExpenses += expense.amount;
        }

        let expenseName;
        switch (expense.type) {
        case type.DINNER:
            expenseName = "Dinner";
            break;
        case type.BREAKFAST:
            expenseName = "Breakfast";
            break;
        case type.CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        const mealOverExpensesMarker = ((expense.type == type.DINNER && expense.amount > 5000) || (expense.type == type.BREAKFAST && expense.amount > 1000)) ? "X" : " ";

        if (htmlMode) {
            process.stdout.write("<tr><td>" + expenseName + "</td><td>" + expense.amount + "</td><td>" + mealOverExpensesMarker + "</td></tr>\n");
        } else {
            process.stdout.write(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker + "\n");
        }
        total += expense.amount;
    }
    if (htmlMode) {
        process.stdout.write("</tbody>\n");
        process.stdout.write("</table>\n");
    }

    if (htmlMode) {
        process.stdout.write("<p>Meal expenses: " + mealExpenses + "</p>\n");
        process.stdout.write("<p>Total expenses: " + total + "</p>\n");
    } else {
        process.stdout.write("Meal expenses: " + mealExpenses + "\n");
        process.stdout.write("Total expenses: " + total + "\n");
    }

    if (htmlMode) {
        process.stdout.write("</body>\n");
        process.stdout.write("</html>\n");
    }
}
