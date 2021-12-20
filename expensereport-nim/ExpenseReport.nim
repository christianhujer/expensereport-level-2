type
  ExpenseType = enum DINNER, BREAKFAST, CAR_RENTAL
  Expense = tuple[expenseType: ExpenseType, amount: int]

proc printReport(expenses: seq[Expense], htmlMode: bool) =
  var meals: int = 0
  var total: int = 0
  if htmlMode:
    echo "<!DOCTYPE html>"
    echo "<html lang=\"en\">"
    echo "<head>"
    echo "<title>Expense Report</title>"
    echo "</head>"
    echo "<body>"
    echo "<h1>Expense Report</h1>>"
  else:
    echo "Expense Report"

  if htmlMode:
    echo "<table>"
    echo "<thead>"
    echo "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>"
    echo "</thead>"
    echo "<tbody>"
  for i, expense in expenses:
    if expense.expenseType == DINNER or expense.expenseType == BREAKFAST:
      meals += expense.amount
    var name: string = ""
    case expense.expenseType
    of DINNER: name = "Dinner"
    of BREAKFAST: name = "Breakfast"
    of CAR_RENTAL: name = "Car Rental"
    let mealOverExpensesMarker = if expense.expenseType == DINNER and expense.amount > 5000 or expense.expenseType == BREAKFAST and expense.amount > 1000: "X" else: " "
    if htmlMode:
      echo "<tr><td>", name, "</td><td>", expense.amount, "</td><td>", mealOverExpensesMarker, "</td></tr>"
    else:
      echo name, "\t", expense.amount, "\t", mealOverExpensesMarker
    total += expense.amount
  if htmlMode:
    echo "</tbody>"
    echo "</table>"

  if htmlMode:
    echo "<p>Meal expenses: ", meals, "</p>"
    echo "<p>Total expenses: ", total, "</p>"
  else:
    echo "Meal expenses: ", meals
    echo "Total expenses: ", total

  if htmlMode:
    echo "</body>"
    echo "</html>"

printReport(@[(expenseType: DINNER, amount: 5000), (expenseType: DINNER, amount: 5001), (expenseType: BREAKFAST, amount: 1000), (expenseType: BREAKFAST, amount: 1001), (expenseType: CAR_RENTAL, amount: 4)], true)
