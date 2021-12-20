#include <chrono>
#include <iostream>
#include <iterator>
#include <list>

using namespace std;

enum Type
{
    BREAKFAST, DINNER, CAR_RENTAL
};

class Expense
{
    public:
    Type type;
    int amount;
};

void printReport(list<Expense> expenses, bool htmlMode)
{
    int total = 0;
    int mealExpenses = 0;

    auto now = chrono::system_clock::to_time_t(chrono::system_clock::now());

    if (htmlMode) {
        cout << "<!DOCTYPE html>" << '\n';
        cout << "<html lang=\"en\">" << '\n';
        cout << "<head>" << '\n';
        cout << "<title>Expense Report " << ctime(&now) << "</title>\n";
        cout << "</head>" << '\n';
        cout << "<body>" << '\n';
    } else {
        cout << "Expenses " << ctime(&now);
    }

    if (htmlMode) {
        cout << "<table>" << '\n';
        cout << "<thead>" << '\n';
        cout << "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>" << '\n';
        cout << "</thead>" << '\n';
        cout << "<tbody>" << '\n';
    }
    for (list<Expense>::iterator expense = expenses.begin(); expense != expenses.end(); ++expense) {
        if (expense->type == BREAKFAST || expense->type == DINNER) {
            mealExpenses += expense->amount;
        }

        string expenseName = "";
        switch (expense->type) {
        case DINNER:
            expenseName = "Dinner";
            break;
        case BREAKFAST:
            expenseName = "Breakfast";
            break;
        case CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        string mealOverExpensesMarker = (expense->type == DINNER && expense->amount > 5000) || (expense->type == BREAKFAST && expense->amount > 1000) ? "X" : " ";

        if (htmlMode) {
            cout << "<tr><td>" << expenseName << "</td><td>" << expense->amount << "</td><td>" << mealOverExpensesMarker << "</td></tr>\n";
        } else {
            cout << expenseName << '\t' << expense->amount << '\t' << mealOverExpensesMarker << '\n';
        }

        total += expense->amount;
    }
    if (htmlMode) {
        cout << "</tbody>" << '\n';
        cout << "</table>" << '\n';
    }

    if (htmlMode) {
        cout << "<p>Meal expenses: " << mealExpenses << "</p>\n";
        cout << "</p>Total expenses: " << total << "</p>\n";
    } else {
        cout << "Meal expenses: " << mealExpenses << '\n';
        cout << "Total expenses: " << total << '\n';
    }

    if (htmlMode) {
        cout << "</body>" << '\n';
        cout << "</html>" << '\n';
    }
}
