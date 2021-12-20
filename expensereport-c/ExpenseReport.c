#include <stdbool.h>
#include <stdio.h>
#include <time.h>

enum Type {
    DINNER,
    BREAKFAST,
    CAR_RENTAL
};

struct Expense {
    enum Type type;
    int amount;
};

void printExpenses(struct Expense expenses[], size_t numExpenses, bool htmlMode) {
    int total = 0;
    int mealExpenses = 0;

    time_t now;
    if (time(&now) == -1)
        return;

    if (htmlMode) {
        printf("<!DOCTYPE html>\n");
        printf("<html lang=\"en\">\n");
        printf("<head>\n");
        printf("<title>Expense Report %s</title>\n", ctime(&now));
        printf("</head>\n");
        printf("<body>\n");
        printf("<h1>Expense Report %s</h1>\n", ctime(&now));
    } else {
        printf("Expenses %s", ctime(&now));
    }

    if (htmlMode) {
        printf("<table>\n");
        printf("<tbody>\n");
        printf("<tr><th span=\"col\">Type</th><th span=\"col\">Amount</th><th span=\"col\">Over Limit</th></tr>\n");
    }
    for (size_t i = 0; i < numExpenses; i++) {
        struct Expense expense = expenses[i];

        if (expense.type == DINNER || expense.type == BREAKFAST) {
            mealExpenses += expense.amount;
        }

        char *expenseName;
        switch (expense.type) {
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

        char *mealOverExpensesMarker = ((expense.type == DINNER && expense.amount > 5000) || (expense.type == BREAKFAST && expense.amount > 1000)) ? "X" : " ";

        if (htmlMode) {
            printf("<tr><td>%s</td><td>%d</td><td>%s</td></tr>\n", expenseName, expense.amount, mealOverExpensesMarker);
        } else {
            printf("%s\t%d\t%s\n", expenseName, expense.amount, mealOverExpensesMarker);
        }
        total += expense.amount;
    }
    if (htmlMode) {
        printf("</tbody>\n");
        printf("</table>\n");
    }

    if (htmlMode) {
        printf("<p>Meal expenses: %d</p>\n", mealExpenses);
        printf("<p>Total expenses: %d</p>\n", total);
    } else {
        printf("Meal expenses: %d\n", mealExpenses);
        printf("Total expenses: %d\n", total);
    }

    if (htmlMode) {
        printf("</body>\n");
        printf("</html>\n");
    }
}
