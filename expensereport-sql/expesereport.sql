#!/bin/sh
sqlite3 <<END
CREATE TABLE Mode (
    htmlMode BOOLEAN NOT NULL
);

CREATE TABLE Expenses (
    type VARCHAR(10) NOT NULL,
    amount INT NOT NULL
);

INSERT INTO Mode (htmlMode) VALUES (FALSE);

INSERT INTO Expenses (type, amount) VALUES
("dinner", 5000),
("dinner", 5001),
("breakfast", 1000),
("breakfast", 1001),
("car_rental", 4);

SELECT CASE WHEN htmlMode THEN printf('<!DOCTYPE html>
<html lang="en">
<head>
<title>Expense Report</title>
</head>
<body>
<h1>Expense Report</h1>
<table>
<thead>
<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>') ELSE printf("Expense Report:") END FROM Mode;
SELECT CASE WHEN htmlMode THEN printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", type, amount, substr(" X", (type = "dinner" and amount > 5000 or type = "breakfast" and amount > 1000) + 1, 1)) ELSE printf("%s	%s	%s", type, amount, substr(" X", (type = "dinner" and amount > 5000 or type = "breakfast" and amount > 1000) + 1, 1)) END
    FROM Expenses, Mode;
SELECT CASE WHEN htmlMode THEN printf("<p>Meal expenses: %s</p>", sum(amount)) ELSE printf("Meal expenses: %s", sum(amount)) END
    FROM Expenses, Mode
    WHERE type = "dinner" OR type = "breakfast";
SELECT CASE WHEN htmlMode THEN printf("<p>Total expenses: %s</p>", sum(amount)) ELSE printf("Total expenses: %s", sum(amount)) END
    FROM Expenses, Mode;
SELEcT CASE WHEN htmlMode THEN printf('</body>
</html>') ELSE printf('') END FROM Mode;

END
