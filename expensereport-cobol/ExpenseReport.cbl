       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXPENSE-REPORT.

       DATA DIVISION.
            WORKING-STORAGE SECTION.
            01 TOTAL PIC 9(10) VALUE 0.
            01 MEALS PIC 9(10) VALUE 0.
            01 EXPENSENAME PIC A(11).
            01 MOEMARKER PIC A(1).
            01 WS-TABLE.
                05 WS-EXPENSES OCCURS 5 TIMES INDEXED BY I.
                    10 WS-TYPE PIC 9(1).
                    10 WS-AMOUNT PIC 9(10).
            01 FORMATTED-INT PIC Z(04)9.
            01 HTML-MODE PIC 9(1) VALUE 1.

       PROCEDURE DIVISION.
           MOVE 1 TO WS-TYPE(1)
           MOVE 1 TO WS-TYPE(2)
           MOVE 2 TO WS-TYPE(3)
           MOVE 2 TO WS-TYPE(4)
           MOVE 3 TO WS-TYPE(5)
           MOVE 5000 TO WS-AMOUNT(1)
           MOVE 5001 TO WS-AMOUNT(2)
           MOVE 1000 TO WS-AMOUNT(3)
           MOVE 1001 TO WS-AMOUNT(4)
           MOVE 4 TO WS-AMOUNT(5)
           PERFORM PRINTREPORT
           STOP RUN.

       PRINTREPORT.
           IF HTML-MODE = 1
               DISPLAY '<!DOCTYPE html>'
               DISPLAY '<html lang="en">'
               DISPLAY '<head>'
               DISPLAY '<title>Expense Report</title>'
               DISPLAY '</head>'
               DISPLAY '<body>'
               DISPLAY '<h1>Expense Report</h1>'
           ELSE
               DISPLAY 'Expenses: '
           END-IF.

           IF HTML-MODE = 1
               DISPLAY '<table>'
               DISPLAY '<thead>'
               DISPLAY '<tr>'
               DISPLAY '<th scope="col">Type</th>'
               DISPLAY '<th scope="col">Amount</th>'
               DISPLAY '<th scope="col">Over Limit</th>'
               DISPLAY '</tr>'
               DISPLAY '</thead>'
               DISPLAY '<tbody>'
           END-IF
           MOVE 1 TO I
           PERFORM SHOWEXPENSEDETAIL
           IF HTML-MODE = 1
               DISPLAY '</tbody>'
               DISPLAY '</table>'
           END-IF.
           MOVE MEALS TO FORMATTED-INT
           IF HTML-MODE = 1
               DISPLAY "<p>Meals: "FORMATTED-INT"</p>"
           ELSE
               DISPLAY "Meals: "FORMATTED-INT
           END-IF.
           MOVE TOTAL TO FORMATTED-INT
           IF HTML-MODE = 1
               DISPLAY "<p>Total: "FORMATTED-INT"</p>"
           ELSE
               DISPLAY "Total: "FORMATTED-INT
           END-IF.
           IF HTML-MODE = 1
               DISPLAY '</body>'
               DISPLAY '</html>'
           END-IF.

       SHOWEXPENSEDETAIL.
           IF WS-TYPE(I) = 1 OR 2
               ADD WS-AMOUNT(I) TO MEALS
           END-IF
           EVALUATE WS-TYPE(I)
               WHEN 1 MOVE 'Dinner'      TO EXPENSENAME
               WHEN 2 MOVE 'Breakfast'   TO EXPENSENAME
               WHEN 3 MOVE 'Car Rental'  TO EXPENSENAME
           END-EVALUATE.
           IF WS-TYPE(I) = 1 AND WS-AMOUNT(I) > 5000
           OR WS-TYPE(I) = 2 AND WS-AMOUNT(I) > 1000
               MOVE 'X' TO MOEMARKER
           ELSE
               MOVE ' ' TO MOEMARKER
           END-IF.
           MOVE WS-AMOUNT(I) TO FORMATTED-INT
           IF HTML-MODE = 1
               DISPLAY "<tr>"
               DISPLAY "<td>"EXPENSENAME"</td>"
               DISPLAY "<td>"FORMATTED-INT"</td>"
               DISPLAY "<td>"MOEMARKER"</td>"
               DISPLAY "</tr>"
           ELSE
               DISPLAY EXPENSENAME FORMATTED-INT ' ' MOEMARKER
           END-IF
           ADD WS-AMOUNT(I) TO TOTAL
           IF I < 5
               ADD 1 TO I
               PERFORM SHOWEXPENSEDETAIL
           END-IF.
