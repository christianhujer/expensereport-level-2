(defstruct expense
    type
    amount
)

(defvar NL "
")
(defvar TAB "	")

(defun print-report (htmlMode &rest expenses)
    (defvar mealExpenses 0)
    (defvar total 0)
    (if htmlMode
        (progn
            (princ (concatenate 'string "<!DOCTYPE html>" NL))
            (princ (concatenate 'string "<html lang=\"en\">" NL))
            (princ (concatenate 'string "<html>" NL))
            (princ (concatenate 'string "<head>" NL))
            (princ (concatenate 'string "<title>Expense Report</title>" NL))
            (princ (concatenate 'string "</head>" NL))
            (princ (concatenate 'string "<body>" NL))
            (princ (concatenate 'string "<h1>Expense Report</h1>" NL))
        )
        (princ (concatenate 'string "Expenses:" NL))
    )

    (if htmlMode
        (progn
            (princ (concatenate 'string "<table>" NL))
            (princ (concatenate 'string "<thead>" NL))
            (princ (concatenate 'string "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>" NL))
            (princ (concatenate 'string "</thead>" NL))
            (princ (concatenate 'string "<tbody>" NL))
        )
    )
    (loop for expense in expenses do
        (if (or (eq (expense-type expense) :dinner) (eq (expense-type expense) :breakfast))
            (setq mealExpenses (+ mealExpenses (expense-amount expense))))
        (defvar expenseName "")
        (case (expense-type expense)
            (:dinner (setq expenseName "Dinner"))
            (:breakfast (setq expenseName "Breakfast"))
            (:car_rental (setq expenseName "Car Rental"))
        )
        (setq mealOverExpensesMarker (if (or (and (eq (expense-type expense) :dinner) (> (expense-amount expense) 5000)) (and (eq (expense-type expense) :breakfast) (> (expense-amount expense) 1000))) "X" " "))
        (if htmlMode
            (princ (concatenate 'string "<tr><td>" expenseName "</td><td>" (write-to-string (expense-amount expense)) "</td><td>" mealOverExpensesMarker "</td></tr>" NL))
            (princ (concatenate 'string expenseName TAB (write-to-string (expense-amount expense)) TAB mealOverExpensesMarker NL))
        )
        (setq total (+ total (expense-amount expense)))
    )
    (if htmlMode
        (progn
            (princ (concatenate 'string "</tbody>" NL))
            (princ (concatenate 'string "</table>" NL))
        )
    )
    (if htmlMode
        (progn
            (princ (concatenate 'string "<p>Meal Expenses: " (write-to-string mealExpenses) "</p>" NL))
            (princ (concatenate 'string "<p>Total Expenses: " (write-to-string total) "</p>" NL))
        )
        (progn
            (princ (concatenate 'string "Meal Expenses: " (write-to-string mealExpenses) NL))
            (princ (concatenate 'string "Total Expenses: " (write-to-string total) NL))
        )
    )
    (if htmlMode
        (progn
            (princ (concatenate 'string "</body>" NL))
            (princ (concatenate 'string "</html>" NL))
        )
    )
)

(print-report
    T
    (make-expense :type :dinner :amount 5000)
    (make-expense :type :dinner :amount 5001)
    (make-expense :type :breakfast :amount 1000)
    (make-expense :type :breakfast :amount 1001)
    (make-expense :type :car_rental :amount 4)
)
