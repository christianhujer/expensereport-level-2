      MODULE ExpenseReport
        IMPLICIT NONE
        ENUM, BIND(C)
          ENUMERATOR :: BREAKFAST, DINNER, CAR_RENTAL
        ENDENUM

        TYPE :: expense
          INTEGER :: type
          INTEGER :: amount
        END TYPE

        CONTAINS
        SUBROUTINE printReport(htmlMode, expenses)
          INTEGER :: htmlMode
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          INTEGER :: total = 0
          INTEGER :: mealExpenses = 0
          INTEGER :: i
          CHARACTER(LEN = 20) :: expenseName
          CHARACTER(LEN = 1) :: mealOverExpensesMarker
          IF (htmlMode == 1) THEN
            PRINT "(a)", '<!DOCTYPE html>'
            PRINT "(a)", '<html lang="en">'
            PRINT "(a)", '<head>'
            PRINT "(a)", '<title>Expense Report</title>'
            PRINT "(a)", '</head>'
            PRINT "(a)", '<body>'
            PRINT "(a)", '<h1>Expense Report</h1>'
          ELSE
            PRINT "(a)", 'Expense Report'
          END IF

          IF (htmlMode == 1) THEN
            PRINT "(a)", '<table>'
            PRINT "(a)", '<thead>'
            PRINT "(a)", '<tr>'
            PRINT "(a)", '<th scope="col">Type</th>'
            PRINT "(a)", '<th scope="col">Amount</th>'
            PRINT "(a)", '<th scope="col">Over Limit</th>'
            PRINT "(a)", '</tr>'
            PRINT "(a)", '</thead>'
            PRINT "(a)", '<tbody>'
          END IF
          DO i = LBOUND(expenses, 1), UBOUND(expenses, 1)
            IF (expenses(i)%type == BREAKFAST .OR. expenses(i)%type == DINNER) &
              mealExpenses = mealExpenses + expenses(i)%amount
            SELECT CASE (expenses(i)%type)
              CASE (DINNER)
                expenseName = "Dinner"
              CASE (BREAKFAST)
                expenseName = "Breakfast"
              CASE (CAR_RENTAL)
                expenseName = "Car Rental"
            END SELECT
            IF (expenses(i)%type == BREAKFAST .AND. expenses(i)%amount > 1000 .OR. &
                expenses(i)%type == DINNER .AND. expenses(i)%amount > 5000) THEN
              mealOverExpensesMarker = "X"
            ELSE
              mealOverExpensesMarker = " "
            END IF
            total = total + expenses(i)%amount
            IF (htmlMode == 1) THEN
              PRINT "(a,a,a,1x,i10,a,1x,a,a)", &
                '<tr><td>', &
                expenseName, &
                '</td><td>', &
                expenses(i)%amount, &
                '</td><td>', &
                mealOverExpensesMarker, &
                '</td></tr>'
            ELSE
              PRINT "(a,1x,i10,1x,a)", expenseName, expenses(i)%amount, mealOverExpensesMarker
            END IF
          END DO
          IF (htmlMode == 1) THEN
            PRINT "(a)", '</tbody>'
            PRINT "(a)", '</table>'
          END IF

          IF (htmlMode == 1) THEN
            PRINT "(a,i10,a)", '<p>Meal expenses: ', mealExpenses, &
              '</p>'
            PRINT "(a,i10,a)", '<p>Total: ', total, '</p>'
          ELSE
            PRINT "(a,i10)", 'Meal expenses: ', mealExpenses
            PRINT "(a,i10)", 'Total: ', total
          END IF

          IF (htmlMode == 1) THEN
            PRINT "(a)", '</body>'
            PRINT "(a)", '</html>'
          END IF
        END SUBROUTINE printReport

      END MODULE ExpenseReport

      PROGRAM main
        USE ExpenseReport
        IMPLICIT NONE
        TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
        ALLOCATE(expenses(5))
        expenses(1)%type = BREAKFAST
        expenses(1)%amount = 1000
        expenses(2)%type = BREAKFAST
        expenses(2)%amount = 1001
        expenses(3)%type = DINNER
        expenses(3)%amount = 5000
        expenses(4)%type = DINNER
        expenses(4)%amount = 5001
        expenses(5)%type = CAR_RENTAL
        expenses(5)%amount = 4
        CALL printReport(1, expenses)
        DEALLOCATE(expenses)
      END PROGRAM main
