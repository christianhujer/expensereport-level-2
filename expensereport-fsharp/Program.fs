// vi: filetype=cs
open System

type ExpenseType = DINNER | BREAKFAST | CAR_RENTAL

type Expense(expenseType: ExpenseType, amount: int) =
    member this.expenseType = expenseType
    member this.amount = amount

let printReport (htmlMode: bool, expenses: seq<Expense>) =
    let mutable total = 0
    let mutable mealExpenses = 0
    if htmlMode then
        printfn "<!DOCTYPE html>"
        printfn "<html lang=\"en\">"
        printfn "<head>"
        printfn "<title>Expense Report: %s</title>" (DateTime.Now.ToString())
        printfn "</head>"
        printfn "<body>"
        printfn "<h1>Expense Report: %s</h1>" (DateTime.Now.ToString())
    else
        printfn "Expense Report: %s" (DateTime.Now.ToString())

    if htmlMode then
        printfn "<table>"
        printfn "<thead>"
        printfn "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>"
        printfn "</thead>"
        printfn "<tbody>"
    for expense in expenses do
        if (expense.expenseType = DINNER || expense.expenseType = BREAKFAST) then
            mealExpenses <- mealExpenses + expense.amount
        let mutable expenseName = ""
        match expense.expenseType with
        | DINNER -> expenseName <- "Dinner"
        | BREAKFAST -> expenseName <- "Breakfast"
        | CAR_RENTAL -> expenseName <- "Car Rental"
        let mealOverExpensesMarker = if (expense.expenseType = DINNER && expense.amount > 5000 || expense.expenseType = BREAKFAST && expense.amount > 1000) then "X" else " "
        if htmlMode then
            printfn "<tr><td>%s</td><td>%d</td><td>%s</td></tr>" expenseName expense.amount mealOverExpensesMarker
        else
            printfn "%s\t%d\t%s" expenseName expense.amount mealOverExpensesMarker
        total <- total + expense.amount
    if htmlMode then
        printfn "</tbody>"
        printfn "</table>"

    if htmlMode then
        printfn "<p>Meal Expenses: %d</p>" mealExpenses
        printfn "<p>Total Expenses: %d</p>" total
    else
        printfn "Meal Expenses: %d" mealExpenses
        printfn "Total Expenses: %d" total

    if htmlMode then
        printfn "</body>"
        printfn "</html>"

[<EntryPoint>]
let main argv =
    printReport(true, [
        Expense(DINNER, 5000)
        Expense(DINNER, 5001)
        Expense(BREAKFAST, 1000)
        Expense(BREAKFAST, 1001)
        Expense(CAR_RENTAL, 4)
    ])
    0
