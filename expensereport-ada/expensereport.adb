with Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded, Ada.Strings.Fixed, Ada.Characters.Latin_1;
use Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded;

procedure expensereport is
    type ExpenseType is (Breakfast, Dinner, CarRental);

    type Expense is tagged record
        eType: ExpenseType;
        amount: Integer;
    end record;

    type ExpenseList is array(Positive range <>) of Expense;

    procedure printReport(expenses: in ExpenseList; htmlMode: in Boolean) is
        total : Integer := 0;
        mealExpenses : Integer := 0;
        expenseName : Unbounded_String;
        mealOverExpensesMarker : Character := ' ';
    begin
        if (htmlMode) then
            Put_Line("<!DOCTYPE html>");
            Put_Line("<html lang=""en"">");
            Put_Line("<head>");
            Put_Line("<title>Expense Report</title>");
            Put_Line("</head>");
            Put_Line("<body>");
            Put_Line("<h1>Expense Report</h1>");
        else
            Put_Line("Expense Report");
        end if;

        if (htmlMode) then
            Put_Line("<table>");
            Put_Line("<thead>");
            Put_Line("<tr><th>Type</th><th>Amount</th><th>Over Limit</th></tr>");
            Put_Line("</thead>");
            Put_Line("<tbody>");
        end if;
        for i in expenses'Range loop
            if (expenses(i).eType = Breakfast or expenses(i).eType = Dinner) then
                mealExpenses := mealExpenses + expenses(i).amount;
            end if;
            expenseName := To_Unbounded_String("Foo" & "Foo");
            case expenses(i).eType is
                when Breakfast =>
                    expenseName := To_Unbounded_String("Breakfast");
                when Dinner =>
                    expenseName := To_Unbounded_String("Dinner");
                when CarRental =>
                    expenseName := To_Unbounded_String("Car Rental");
            end case;
            if ((expenses(i).eType = Breakfast and expenses(i).amount > 1000) or (expenses(i).eType = Dinner and expenses(i).amount > 5000)) then
                mealOverExpensesMarker := 'X';
            else
                mealOverExpensesMarker := ' ';
            end if;
            if (htmlMode) then
                Put_Line("<tr><td>" & expenseName & "</td><td>" & Ada.Strings.Fixed.Trim(Integer'Image(expenses(i).amount), Ada.Strings.Left) & "</td><td>" & mealOverExpensesMarker & "</td></tr>");
            else
                Put_Line(expenseName & Ada.Characters.Latin_1.HT & Ada.Strings.Fixed.Trim(Integer'Image(expenses(i).amount), Ada.Strings.Left) & Ada.Characters.Latin_1.HT & mealOverExpensesMarker);
            end if;
            total := total + expenses(i).amount;
        end loop;
        if (htmlMode) then
            Put_Line("</tbody>");
            Put_Line("</table>");
        end if;

        if (htmlMode) then
            Put_Line("<p>Meal expenses:" & Integer'Image(mealExpenses) & "</p>");
            Put_Line("<p>Total expenses:" & Integer'Image(total) & "</p>");
        else
            Put_Line("Meal expenses:" & Integer'Image(mealExpenses));
            Put_Line("Total expenses:" & Integer'Image(total));
        end if;

        if (htmlMode) then
            Put_Line("</body>");
            Put_Line("</html>");
        end if;
    end printReport;

    expenses : ExpenseList := (
        (Breakfast, 1000),
        (Breakfast, 1001),
        (Dinner, 5000),
        (Dinner, 5001),
        (CarRental, 4)
    );
begin
    printReport(expenses, true);
end expensereport;
