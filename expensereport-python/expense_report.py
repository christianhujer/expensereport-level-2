import locale
from enum import Enum, unique, auto
from datetime import datetime
from typing import List


@unique
class ExpenseType(Enum):
    DINNER = auto()
    BREAKFAST = auto()
    CAR_RENTAL = auto()


class Expense:
    type: ExpenseType
    amount: int


class ExpenseReport:
    def print_report(self, expenses: List[Expense], html_mode: bool):
        total = 0
        meals = 0

        if html_mode:
            print("<!DOCTYPE html>")
            print("<html lang=\"en\">")
            print("<head>")
            print("<title>Expense Report", datetime.now().strftime(locale.nl_langinfo(locale.D_T_FMT)), "</title>")
            print("</head>")
            print("<body>")
            print("<h1>Expense Report", datetime.now().strftime(locale.nl_langinfo(locale.D_T_FMT)), "</h1>")
        else:
            print("Expense Report", datetime.now().strftime(locale.nl_langinfo(locale.D_T_FMT)))

        if html_mode:
            print("<table>")
            print("<thead>")
            print("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amoutn</th><th scope=\"col\">Over Limit</th></tr>")
            print("</thead>")
            print("<tbody>")
        for expense in expenses:
            if expense.type == ExpenseType.DINNER or expense.type == ExpenseType.BREAKFAST:
                meals += expense.amount

            name = ""
            if expense.type == ExpenseType.DINNER:
                name = "Dinner"
            elif expense.type == ExpenseType.BREAKFAST:
                name = "Breakfast"
            elif expense.type == ExpenseType.CAR_RENTAL:
                name = "Car Rental"

            meal_over_expenses_marker = "X" if expense.type == ExpenseType.DINNER and expense.amount > 5000 or expense.type == ExpenseType.BREAKFAST and expense.amount > 1000 else " "
            if html_mode:
                print("<tr><td>", name, "</td><td>", expense.amount, "</td><td>", meal_over_expenses_marker, "</td></tr>")
            else:
                print(name, "\t", expense.amount, "\t", meal_over_expenses_marker)
            total += expense.amount
        if html_mode:
            print("</tbody>")
            print("</table>")

        if html_mode:
            print("<p>Meal Expenses:", meals, "</p>")
            print("<p>Total Expenses:", total, "</p>")
        else:
            print("Meals:", meals)
            print("Total:", total)

        if html_mode:
            print("</body>")
            print("</html>")
