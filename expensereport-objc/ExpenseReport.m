#include <stdbool.h>
#include <stdio.h>
#include <time.h>

typedef enum {
    DINNER,
    BREAKFAST,
    CAR_RENTAL
} ExpenseType;

struct Expense {
    ExpenseType type;
    int amount;
} Expense;

void printReport(bool htmlMode, struct Expense expenses[], size_t numExpenses) {
    int total = 0;
    int mealExpenses = 0;

    int i;
    time_t now;
    if (time(&now) == -1)
        return;

    if (htmlMode) {
        printf("<!DOCTYPE html>\n");
        printf("<html lang=\"en\">\n");
        printf("<head>\n");
        printf("<title>Expense Report: %s</title>\n", ctime(&now));
        printf("</head>\n");
        printf("<body>\n");
        printf("<h1>Expense Report: %s</h1>\n", ctime(&now));
    } else {
        printf("Expenses %s:\n", ctime(&now));
    }

    if (htmlMode) {
        printf("<table>\n");
        printf("<thead>\n");
        printf("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>\n");
        printf("</thead>\n");
        printf("<tbody>\n");
    }
    for (i = 0; i < numExpenses; i++) {
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

int main(void) {
    struct Expense expenses[5];
    expenses[0].type = DINNER; expenses[0].amount = 5000;
    expenses[1].type = DINNER; expenses[1].amount = 5001;
    expenses[2].type = BREAKFAST; expenses[2].amount = 1000;
    expenses[3].type = BREAKFAST; expenses[3].amount = 1001;
    expenses[4].type = CAR_RENTAL; expenses[4].amount = 4;
    printReport(true, expenses, 5);
    return 0;
}
