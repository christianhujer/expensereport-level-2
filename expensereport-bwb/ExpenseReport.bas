10 DINNER = 0: BREAKFAST = 1: CARRENTAL = 2
20 DIM TYPE(4): DIM AMOUNT(4)
30 TYPE(0) = DINNER: AMOUNT(0) = 5000
40 TYPE(1) = DINNER: AMOUNT(1) = 5001
50 TYPE(2) = BREAKFAST: AMOUNT(2) = 1000
60 TYPE(3) = BREAKFAST: AMOUNT(3) = 1001
70 TYPE(4) = CARRENTAL: AMOUNT(4) = 4
80 htmlMode = 1
90 GOSUB 1000
100 QUIT
1000 REM PRINTREPORT
1010 MEALS = 0: SUM = 0
1011 IF htmlMode = 0 THEN GOTO 1020
1011 PRINT "<!DOCTYPE html>"
1012 PRINT "<html lang="; CHR$(34); "en"; CHR$(34); ">"
1013 PRINT "<head>"
1014 PRINT "<title>Expense Report</title>"
1015 PRINT "</head>"
1016 PRINT "<body>"
1017 PRINT "<h1>Expense Report</h1>"
1018 GOTO 1021
1020 PRINT "Expense Report:"
1021 IF htmlMode = 0 THEN GOTO 1030
1022 PRINT "<table>"
1023 PRINT "<thead>"
1024 PRINT "<tr><th scope="; CHR$(34); "col"; CHR$(34); ">Type</th><th scope="; CHR$(34); "col"; CHR$(34); ">Amount</th><th scope="; CHR$(34); "col"; CHR$(34); ">Over Limit</th></tr>"
1025 PRINT "</thead>"
1026 PRINT "<tbody>"
1030 FOR I = 0 TO 4
1040 IF TYPE(I) = 0 OR TYPE(I) = 1 THEN MEALS = MEALS + AMOUNT(I)
1050 NAME$ = ""
1060 IF TYPE(I) = 0 THEN NAME$ = "Dinner"
1070 IF TYPE(I) = 1 THEN NAME$ = "Breakfast"
1080 IF TYPE(I) = 2 THEN NAME$ = "Car Rental"
1090 IF TYPE(I) = 0 AND AMOUNT(I) > 5000 THEN GOTO 1130
1100 IF TYPE(I) = 1 AND AMOUNT(I) > 1000 THEN GOTO 1130
1110 MARKER$ = " "
1120 GOTO 1140
1130 MARKER$ = "X"
1140 IF htmlMode = 0 THEN GOTO 1145
1141 PRINT "<tr><td>"; NAME$; "</td><td>"; AMOUNT(I); "</td><td>"; MARKER$; "</td></tr>"
1142 GOTO 1150
1145 PRINT NAME$, AMOUNT(I), MARKER$
1150 SUM = SUM + AMOUNT(I)
1160 NEXT I
1161 IF htmlMode = 0 THEN GOTO 1165
1162 PRINT "</tbody>"
1163 PRINT "</table>"
1165 IF htmlMode = 0 THEN GOTO 1170
1166 PRINT "<p>Meal Expenses: "; MEALS; "</p>"
1167 PRINT "<p>Total Expenses: "; SUM; "</p>"
1168 GOTO 1190
1170 PRINT "Meal Expenses: "; MEALS
1180 PRINT "Total Expenses: "; SUM
1190 IF htmlMode = 0 THEN GOTO 1200
1191 PRINT "</body>"
1192 PRINT "</html>"
1200 RETURN
