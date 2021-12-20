#!/usr/bin/env -S guile -s
!#

(define (print-report html-mode expenses)
    (define meal-expenses 0)
    (define total-expenses 0)

    (display
        (if html-mode
            (string-concatenate (list
                "<!DOCTYPE html>\n"
                "<html lang=\"en\">\n"
                "<head>\n"
                "<title>Expense Report " (strftime "%c" (localtime (current-time))) "</title>\n"
                "</head>\n"
                "<body>\n"
                "<h1>Expense Report " (strftime "%c" (localtime (current-time))) "</h1>\n"
            ))
            (string-concatenate (list "Expense Report " (strftime "%c" (localtime (current-time))) "\n"))
        )
    )

    (if html-mode
        (display (string-concatenate (list
            "<table>\n"
            "<thead>\n"
            "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>\n"
            "</thead>\n"
            "<tbody>\n"
        )))
    )
    (for-each
        (lambda (expense)
            (define expense-name "")
            (if (or (eq? (list-ref expense 0) 'dinner) (eq? (list-ref expense 0) 'breakfast)) (set! meal-expenses (+ meal-expenses (list-ref expense 1))))
            (if (eq? (list-ref expense 0) 'dinner) (set! expense-name "Dinner"))
            (if (eq? (list-ref expense 0) 'breakfast) (set! expense-name "Breakfast"))
            (if (eq? (list-ref expense 0) 'car-rental) (set! expense-name "Car Rental"))
            (define meal-over-expenses-marker (if (or (and (eq? (list-ref expense 0) 'dinner) (> (list-ref expense 1) 5000)) (and (eq? (list-ref expense 0) 'breakfast) (> (list-ref expense 1) 1000) )) "X" " "))
            (if html-mode
                (display (string-concatenate (list "<tr><td>" expense-name "</td><td>" (number->string (list-ref expense 1)) "</td><td>" meal-over-expenses-marker "</td></tr>\n")))
                (display (string-concatenate (list expense-name "\t" (number->string (list-ref expense 1)) "\t" meal-over-expenses-marker "\n")))
            )
            (set! total-expenses (+ total-expenses (list-ref expense 1)))
        )
        expenses
    )
    (if html-mode (display "</tbody>\n</table>\n"))

    (if html-mode
        (begin
            (display (string-concatenate (list "<p>Meal expenses: " (number->string meal-expenses) "</p>\n")))
            (display (string-concatenate (list "<p>Total expenses: " (number->string total-expenses) "</p>\n")))
        )
        (begin
            (display (string-concatenate (list "Meal expenses: " (number->string meal-expenses) "\n")))
            (display (string-concatenate (list "Total expenses: " (number->string total-expenses) "\n")))
        )
    )

    (if html-mode (display "</body>\n</html>\n"))
)

(print-report #t (list (list 'dinner 5000) (list 'dinner 5001) (list 'breakfast 1000) (list 'breakfast 1001) (list 'car-rental 4)))
