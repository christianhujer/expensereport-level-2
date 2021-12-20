/* Expense Report */
DINNER = 0; BREAKFAST = 1; CAR_RENTAL = 2

expense.0.type = DINNER; expense.0.amount = 5000
expense.1.type = DINNER; expense.1.amount = 5001
expense.2.type = BREAKFAST; expense.2.amount = 1000
expense.3.type = BREAKFAST; expense.3.amount = 1001
expense.4.type = CAR_RENTAL; expense.4.amount = 4

htmlMode = 1

meals = 0
total = 0
IF htmlMode THEN DO
    SAY "<!DOCTYPE html>"
    SAY "<html lang=""en"">"
    SAY "<head>"
    SAY "<title>Expense Report" DATE() TIME() "</title>"
    SAY "</head>"
    SAY "<body>"
    SAY "<h1>Expense Report" DATE() TIME() "</h1>"
END
ELSE DO
    SAY "Expenses:" DATE() TIME()
END

IF htmlMode THEN DO
    SAY "<table>"
    SAY "<thead>"
    SAY "<tr><th scope=""col"">Type</th><th scope=""col"">Amount</th><th scope=""col"">Over Limit</th></tr>"
    SAY "</thead>"
    SAY "<tbody>"
END
DO i = 0 TO 4
    IF expense.i.type = DINNER | expense.i.type = BREAKFAST THEN meals = meals + expense.i.amount
    SELECT
        WHEN expense.i.type = DINNER THEN expenseName = "Dinner"
        WHEN expense.i.type = BREAKFAST THEN expenseName = "Breakfast"
        WHEN expense.i.type = CAR_RENTAL THEN expenseName = "Car Rental"
    END
    IF expense.i.type = DINNER & expense.i.amount > 5000 | expense.i.type = BREAKFAST & expense.i.amount > 1000 THEN mealOverExpensesMarker = "X"
    ELSE mealOverExpensesMarker = " "
    IF htmlMode THEN DO
        SAY "<tr><td>" expenseName "</td><td>" expense.i.amount "</td><td>" mealOverExpensesMarker "</td></tr>"
    END
    ElSE DO
        SAY expenseName expense.i.amount mealOverExpensesMarker
    END
    total = total + expense.i.amount
END
IF htmlMode THEN DO
    SAY "</tbody>"
    SAY "</table>"
END

IF htmlMode THEN DO
    SAY "<p>Meal expenses:" meals "</p>"
    SAY "<p>Total expenses:" total "</p>"
END
ELSE DO
    SAY "Meal expenses:" meals
    SAY "Total expenses:" total
END

IF htmlMode THEN DO
    SAY "</body>"
    SAY "</html>"
END
