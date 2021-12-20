import Foundation

enum ExpenseType {
    case breakfast
    case dinner
    case carRental
}

struct Expense {
    var type: ExpenseType
    var amount: Int
}

class ExpenseReport {
    func printReport(htmlMode: Bool, expenses: [Expense]) {
        var mealExpenses = 0
        var total = 0
        if (htmlMode) {
            print("""
                <!DOCTYPE html>
                <html lang="en">
                <head>
                <title>Expense Report \(Date())</title>
                </head>
                <body>
                <h1>Expense Report \(Date())</h1>
                """)
        } else {
            print("Expense Report \(Date())")
        }

        if (htmlMode) {
            print("""
                <table>
                <thead>
                <tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
                </thead>
                <tbody>
                """)
        }
        for expense in expenses {
            if (expense.type == .dinner || expense.type == .breakfast) {
                mealExpenses += expense.amount
            }

            var expenseName = ""
            switch expense.type {
            case .breakfast: expenseName = "Breakfast"
            case .dinner: expenseName = "Dinner"
            case .carRental: expenseName = "Car Rental"
            }

            let mealOverExpensesMarker = expense.type == .dinner && expense.amount > 5000 || expense.type == .breakfast && expense.amount > 1000 ? "X" : " "
            if (htmlMode) {
                print("<tr><td>\(expenseName)</td><td>\(expense.amount)</td><td>\(mealOverExpensesMarker)</td></tr>")
            } else {
                print("\(expenseName)\t\(expense.amount)\t\(mealOverExpensesMarker)")
            }

            total += expense.amount
        }
        if (htmlMode) {
            print("""
                </tbody>
                </table>
                """)
        }

        if (htmlMode) {
            print("<p>Meal Expenses: \(mealExpenses)</p>")
            print("<p>Total Expenses: \(total)</p>")
        } else {
            print("Meal Expenses: \(mealExpenses)")
            print("Total Expenses: \(total)")
        }

        if (htmlMode) {
            print("""
                </body>
                </html>
                """)
        }
    }
}
