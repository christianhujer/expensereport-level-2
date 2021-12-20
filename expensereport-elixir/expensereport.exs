#!/usr/bin/env elixir

defmodule Expense do
    defstruct [:type, :amount]
end

defmodule ExpenseReport do
    def printReport(htmlMode, expenses) when is_list(expenses) do

        if htmlMode do
            IO.write("""
                <!DOCTYPE html>
                <html lang="en">
                <head>
                <title>Expense Report</title>
                </head>
                <body>
                <h1>Expense Report</h1>
                """)
        else
            IO.puts("Expense Report")
        end

        if htmlMode do
            IO.write("""
                <table>
                <thead>
                <tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
                </thead>
                <tbody>
                """)
        end
        for expense <- expenses do
            expenseName = case expense.type do
                :breakfast -> "Breakfast"
                :dinner -> "Dinner"
                :carrental -> "Car Rental"
            end
            mealOverExpensesMarker = case expense.type do
                :breakfast -> if expense.amount > 1000 do "X" else " " end
                :dinner -> if expense.amount > 5000 do "X" else " " end
                _ -> " "
            end
            if htmlMode do
                IO.puts("<tr><td>" <> expenseName <> "</td><td>" <> to_string(expense.amount) <> "</td><td>" <> mealOverExpensesMarker <> "</td></tr>")
            else
                IO.puts(expenseName <> "\t" <> to_string(expense.amount) <> "\t" <> mealOverExpensesMarker)
            end
        end
        if htmlMode do
            IO.write("""
                </tbody>
                </table>
                """)
        end

        mealExpenses = Enum.sum(Enum.map(Enum.filter(expenses, fn expense -> expense.type == :breakfast || expense.type == :dinner end), fn expense -> expense.amount end))
        total = Enum.sum(Enum.map(expenses, fn expense -> expense.amount end))

        if htmlMode do
            IO.puts("<p>Meal expenses: " <> to_string(mealExpenses) <> "</p>")
            IO.puts("<p>Total expenses: " <> to_string(total) <> "</p>")
        else
            IO.puts("Meal expenses: " <> to_string(mealExpenses))
            IO.puts("Total expenses: " <> to_string(total))
        end

        if htmlMode do
            IO.write("""
                </body>
                </html>
                """)
        end
    end
end

defmodule Main do
    def main do
        ExpenseReport.printReport(true, [
            %Expense{type: :breakfast, amount: 1000},
            %Expense{type: :breakfast, amount: 1001},
            %Expense{type: :dinner, amount: 5000},
            %Expense{type: :dinner, amount: 5001},
            %Expense{type: :carrental, amount: 4},
        ])
    end
end

Main.main
