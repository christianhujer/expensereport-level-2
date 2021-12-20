Imports System

Module Program
    Enum ExpenseType
        DINNER
        BREAKFAST
        CAR_RENTAL
    End Enum

    Class Expense
        Public expenseType As ExpenseType
        Public amount As Integer
        Public Sub New(nExpenseType As ExpenseType, nAmount As Integer)
            expenseType = nExpenseType
            amount = nAmount
        End Sub
    End Class

    Sub PrintReport(htmlMode As Boolean, expenses As List(Of Expense))
        Dim mealExpenses As Integer = 0
        Dim total As Integer = 0

        IF htmlMode Then
            Console.WriteLine("<!DOCTYPE html>")
            Console.WriteLine("<html lang=""en"">")
            Console.WriteLine("<head>")
            Console.WriteLine("<title>Expense Report</title>")
            Console.WriteLine("</head>")
            Console.WriteLine("<body>")
            Console.WriteLine("<h1>Expense Report<h1>")
        Else
            Console.WriteLine("Expense Report")
        End If

        If htmlMode Then
            Console.WriteLine("<table>")
            Console.WriteLine("<thead>")
            Console.WriteLine("<tr><th scope=""col"">Type</th><th scope=""col"">Amount</th><th scope=""col"">Over Limit</th></tr>")
            Console.WriteLine("</thead>")
            Console.WriteLine("<tbody>")
        End If
        For Each expense In expenses
            If expense.expenseType = ExpenseType.DINNER OR expense.expenseType = ExpenseType.BREAKFAST Then
                mealExpenses += expense.amount
            End If
            Dim expenseName As String = ""
            Select expense.expenseType
                Case ExpenseType.DINNER
                    expenseName = "Dinner"
                Case ExpenseType.BREAKFAST
                    expenseName = "Breakfast"
                Case ExpenseType.CAR_RENTAL
                    expenseName = "Car Rental"
            End Select
            Dim mealOverExpensesMarker As String = If(expense.expenseType = ExpenseType.DINNER AND expense.amount > 5000 OR expense.expenseType = ExpenseType.BREAKFAST AND expense.amount > 1000, "X", " ")
            If htmlMode Then
                Console.WriteLine("<tr><td>" & expenseName & "</td><td>" & expense.amount & "</td><td>" & mealOverExpensesMarker & "</td></tr>")
            Else
                Console.WriteLine(expenseName & Chr(9) & expense.amount & Chr(9) & mealOverExpensesMarker)
            End If
            total += expense.amount
        Next expense
        If htmlMode Then
            Console.WriteLine("</tbody>")
            Console.WriteLine("</table>")
        End If

        If htmlMode Then
            Console.WriteLine("<p>Meal Expenses: " & mealExpenses & "</p>")
            Console.WriteLine("<p>Total Expenses: " & total & "</p>")
        Else
            Console.WriteLine("Meal Expenses: " & mealExpenses)
            Console.WriteLine("Total Expenses: " & total)
        End If

        If htmlMode Then
            Console.WriteLine("</body>")
            Console.WriteLine("</html>")
        End If
    End Sub

    Sub Main(args As String())
        Dim expenses As List(Of Expense) = new List(Of Expense)
        expenses.add(new Expense(ExpenseType.BREAKFAST, 1000))
        expenses.add(new Expense(ExpenseType.BREAKFAST, 1001))
        expenses.add(new Expense(ExpenseType.DINNER, 5000))
        expenses.add(new Expense(ExpenseType.DINNER, 5001))
        expenses.add(new Expense(ExpenseType.CAR_RENTAL, 4))
        PrintReport(true, expenses)
    End Sub
End Module
