import std.stdio;
import std.datetime.systime;

enum ExpenseType { DINNER, BREAKFAST, CAR_RENTAL }

struct Expense {
    ExpenseType type;
    int amount;
}

void printReport(Expense[] expenses, bool htmlMode) {
    int meals = 0;
    int total = 0;
    if (htmlMode) {
        writefln("<!DOCTYPE html>");
        writefln("<html lang=\"en\">");
        writefln("<head>");
        writefln("<title>Expense Report %s</title>", Clock.currTime());
        writefln("</head>");
        writefln("<body>");
        writefln("<h1>Expense Report %s</h1>", Clock.currTime());
    } else {
        writefln("Expenses: %s", Clock.currTime());
    }

    if (htmlMode) {
        writefln("<table>");
        writefln("<tbody>");
        writefln("<tr><th span=\"col\">Type</th><th span=\"col\">Amount</th><th span=\"col\">Over Limit</th></tr>");
    }
    foreach (expense; expenses) {
        if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
            meals += expense.amount;
        }
        string name = "";
        switch (expense.type) {
        case ExpenseType.DINNER: name = "Dinner"; break;
        case ExpenseType.BREAKFAST: name = "Breakfast"; break;
        case ExpenseType.CAR_RENTAL: name = "Car Rental"; break;
        default: name = "";
        }
        string mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " ";
        if (htmlMode) {
            writefln("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", name, expense.amount, mealOverExpensesMarker);
        } else {
            writefln("%s\t%s\t%s", name, expense.amount, mealOverExpensesMarker);
        }
        total += expense.amount;
    }
    if (htmlMode) {
        writefln("</tbody>");
        writefln("</table>");
    }

    if (htmlMode) {
        writefln("<p>Meal expenses: %d</p>", meals);
        writefln("<p>Total expenses: %d</p>", total);
    } else {
        writefln("Meal expenses: %d", meals);
        writefln("Total expenses: %d", total);
    }

    if (htmlMode) {
        writefln("</body>");
        writefln("</html>");
    }
}

void main() {
    Expense[] expenses = [
        { ExpenseType.DINNER, 5000 },
        { ExpenseType.DINNER, 5001 },
        { ExpenseType.BREAKFAST, 1000 },
        { ExpenseType.BREAKFAST, 1001 },
        { ExpenseType.CAR_RENTAL, 4 },
    ];
    printReport(expenses, true);
}
