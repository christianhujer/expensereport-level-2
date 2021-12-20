const message = 'Hello, World!\n';

const sumTwoValues = (a: number, b: number): number => a + b

const printHelloWorld = (): void => {
  process.stdout.write(message);
}

type ExpenseType = "dinner" | "breakfast" | "car-rental"

class Expense {
  type: ExpenseType
  amount: number
  constructor(type: ExpenseType, amount: number) {
    this.type = type
    this.amount = amount
  }
}

function printReport(htmlMode: boolean, expenses: Expense[]) {
  let totalExpenses: number = 0
  let mealExpenses: number = 0

  if (htmlMode) {
    process.stdout.write("<!DOCTYPE html>\n");
    process.stdout.write("<html>\n");
    process.stdout.write("<head>\n");
    process.stdout.write("<title>Expense Report: " + new Date().toISOString().substr(0, 10) + "</title>\n")
    process.stdout.write("</head>\n");
    process.stdout.write("<body>\n");
    process.stdout.write("<h1>Expense Report: " + new Date().toISOString().substr(0, 10) + "</h1>\n")
  } else {
    process.stdout.write("Expense Report: " + new Date().toISOString().substr(0, 10) + "\n")
  }

  if (htmlMode) {
    process.stdout.write("<table>\n");
    process.stdout.write("<thead>\n");
    process.stdout.write("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>\n");
    process.stdout.write("</thead>\n");
    process.stdout.write("<tbody>\n");
  }
  for (const expense of expenses) {
    if (expense.type == "dinner" || expense.type == "breakfast") {
      mealExpenses += expense.amount
    }

    let expenseName = ""
    switch (expense.type) {
      case "dinner":
        expenseName = "Dinner"
        break
      case "breakfast":
        expenseName = "Breakfast"
        break
      case "car-rental":
        expenseName = "Car Rental"
        break
    }

    let mealOverExpensesMarker = expense.type == "dinner" && expense.amount > 5000 || expense.type == "breakfast" && expense.amount > 1000 ? "X" : " "

    if (htmlMode) {
        process.stdout.write("<tr><td>" + expenseName + "</td><td>" + expense.amount + "</td><td>" + mealOverExpensesMarker + "</td></tr>\n")
    } else {
        process.stdout.write(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker + "\n")
    }

    totalExpenses += expense.amount
  }
  if (htmlMode) {
    process.stdout.write("</tbody>\n");
    process.stdout.write("</table>\n");
  }

  if (htmlMode) {
    process.stdout.write("<p>Meal Expenses: " + mealExpenses + "</p>\n")
    process.stdout.write("<p>Total Expenses: " + totalExpenses + "</p>\n")
  } else {
    process.stdout.write("Meal Expenses: " + mealExpenses + "\n")
    process.stdout.write("Total Expenses: " + totalExpenses + "\n")
  }

  if (htmlMode) {
    process.stdout.write("</body>\n");
    process.stdout.write("</html>\n");
  }
}

export {sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType}
