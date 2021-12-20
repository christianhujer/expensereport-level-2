ExpenseType = {
    DINNER = 1,
    BREAKFAST = 2,
    CAR_RENTAL = 3,
}

Expense = { type, amount }

function Expense:new(type, amount)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.type = type
    o.amount = amount
    return o
end

function printReport(expenses, htmlMode)
    mealExpenses = 0
    total = 0
    if htmlMode then
        print("<!DOCTYPE html>")
        print("<html>")
        print("<head>")
        print("<title>Expense Report: " .. os.date() .. "</title>")
        print("</head>")
        print("<body>")
        print("<h1>Expense Report: " .. os.date() .. "</h1>")
    else
        print("Expenses: " .. os.date())
    end

    if htmlMode then
        print("<table>")
        print("<thead>")
        print("<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>")
        print("</thead>")
        print("<tbody>")
    end
    for i, expense in ipairs(expenses) do
        if expense.type == ExpenseType.DINNER or expense.type == ExpenseType.BREAKFAST then
            mealExpenses = mealExpenses + expense.amount
        end
        expenseName = ""
        if expense.type == ExpenseType.DINNER then expenseName = "Dinner" end
        if expense.type == ExpenseType.BREAKFAST then expenseName = "Breakfast" end
        if expense.type == ExpenseType.CAR_RENTAL then expenseName = "Car Rental" end
        mealOverExpensesMarker = (expense.type == ExpenseType.DINNER and expense.amount > 5000 or expense.type == ExpenseType.BREAKFAST and expense.amount > 1000) and "X" or " "
        if htmlMode then
            print("<tr><td>" .. expenseName .. "</td><td>" .. expense.amount .. "</td><td>" .. mealOverExpensesMarker .. "</td></tr>")
        else
            print(expenseName .. "\t" .. expense.amount .. "\t" .. mealOverExpensesMarker)
        end
        total = total + expense.amount
    end
    if htmlMode then
        print("</tbody>")
        print("</table>")
    end

    if htmlMode then
        print("<p>Meal Expenses: " .. mealExpenses .. "</p>")
        print("<p>Total Expenses: " .. total .. "</p>")
    else
        print("Meal Expenses: " .. mealExpenses)
        print("Total Expenses: " .. total)
    end

    if htmlMode then
        print("</body>")
        print("</html>")
    end
end

expenses = {
    Expense:new(ExpenseType.DINNER, 5000),
    Expense:new(ExpenseType.DINNER, 5001),
    Expense:new(ExpenseType.BREAKFAST, 1000),
    Expense:new(ExpenseType.BREAKFAST, 1001),
    Expense:new(ExpenseType.CAR_RENTAL, 4),
}

printReport(expenses, true)
