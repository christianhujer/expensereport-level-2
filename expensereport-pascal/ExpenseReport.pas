PROGRAM ExpenseReport;

USES sysutils;

TYPE
    ExpenseType = (Dinner, Breakfast, CarRental);
    Expense = RECORD
        type_: ExpenseType;
        amount: integer;
    END;

PROCEDURE printReport(expenses: ARRAY OF Expense; htmlMode: BOOLEAN);
VAR total: integer = 0;
VAR mealExpenses: integer = 0;
VAR exp: Expense;
VAR expenseName: string;
VAR mealOverExpensesMarker: string;
BEGIN
    IF htmlMode THEN
    BEGIN
        writeln('<!DOCTYPE html>');
        writeln('<html lang="en">');
        writeln('<head>');
        writeln('<title>Expenses: ', FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), '</title>');
        writeln('</head>');
        writeln('<body>');
        writeln('<h1>Expenses: ', FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), '</h1>');
    END
    ELSE
        writeln('Expenses: ', FormatDateTime('YYYY-MM-DD hh:mm:ss', Now));

    IF htmlMode THEN
    BEGIN
        writeln('<table>');
        writeln('<thead>');
        writeln('<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>');
        writeln('</thead>');
        writeln('<tbody>');
    END;
    FOR exp IN expenses DO
    BEGIN
        IF (exp.type_ = Dinner) OR (exp.type_ = Breakfast) THEN mealExpenses := mealExpenses + exp.amount;
        CASE (exp.type_) of
            Dinner: expenseName := 'Dinner';
            Breakfast: expenseName := 'Breakfast';
            CarRental: expenseName := 'Car Rental';
        END;
        IF (exp.type_ = Dinner) AND (exp.amount > 5000) OR (exp.type_ = Breakfast) AND (exp.amount > 1000) THEN mealOverExpensesMarker := 'X' ELSE mealOverExpensesMarker := ' ';
        IF htmlMode THEN
            writeln('<tr><td>', expenseName, '</td><td>', exp.amount, '</td><td>', mealOverExpensesMarker, '</td></tr>')
        ELSE
            writeln(expenseName, #9, exp.amount, #9, mealOverExpensesMarker);
        total := total + exp.amount;
    END;
    IF htmlMode THEN
    BEGIN
        writeln('</tbody>');
        writeln('</table>');
    END;

    IF htmlMode THEN
    BEGIN
        writeln('<p>Meal expenses: ', mealExpenses, '</p>');
        writeln('<p>Total expenses: ', total, '</p>');
    END
    ELSE
    BEGIN
        writeln('Meal expenses: ', mealExpenses);
        writeln('Total expenses: ', total);
    END;

    IF htmlMode THEN
    BEGIN
        writeln('</body>');
        writeln('</html>');
    END;
END;


VAR expenses: ARRAY OF Expense;
BEGIN
    SetLength(expenses, 5);
    expenses[0].type_ := Breakfast; expenses[0].amount := 1000;
    expenses[1].type_ := Breakfast; expenses[1].amount := 1001;
    expenses[2].type_ := Dinner; expenses[2].amount := 5000;
    expenses[3].type_ := Dinner; expenses[3].amount := 5001;
    expenses[4].type_ := CarRental; expenses[4].amount := 4;
    printReport(expenses, TRUE);
END.
