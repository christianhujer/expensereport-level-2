expense(Type, Amount, [Type, Amount]).

print_report(HtmlMode, [X|Y], Meals, Total) :-
    expense(Type, Amount, X),
    ((Type = dinner; Type = breakfast) -> NMeals is Meals + Amount; NMeals is Meals),

    (Type = dinner -> Name = 'Dinner';
    Type = breakfast -> Name = 'Breakfast';
    Type = car_rental -> Name = 'Car Rental'),

    ((Type = dinner, Amount > 5000; Type = breakfast, Amount > 1000) -> Marker = 'X'; Marker = ' '),

    ( HtmlMode ->
        format('<tr><td>~a</td><td>~a</td><td>~a</td></tr>~n', [Name, Amount, Marker])
    ;
        format('~a\t~a\t~a~n', [Name, Amount, Marker])
    ),
    NTotal is Total + Amount,
    print_report(HtmlMode, Y, NMeals, NTotal).

print_report(HtmlMode, [], Meals, Total) :-
    ( HtmlMode ->
        format('</tbody>~n'),
        format('</table>~n'),
        format('<p>Meal expenses: ~a</p>~n', [Meals]),
        format('<p>Total expenses: ~a</p>~n', [Total]),
        format('</body>~n'),
        format('</html>~n')
    ;
        format('Meal expenses: ~a~n', [Meals]),
        format('Total expenses: ~a~n', [Total])
    ).

print_report(HtmlMode, X) :-
    ( HtmlMode ->
        format('<!DOCTYPE html>~n'),
        format('<html lang="en">~n'),
        format('<head>~n'),
        format('<title>Expense Report</title>~n'),
        format('</head>~n'),
        format('<body>~n'),
        format('<h1>Expense Report</h1>~n'),
        format('<table>~n'),
        format('<thead>~n'),
        format('<tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>~n'),
        format('</thead>~n'),
        format('<tbody>~n')
    ;
        format('Expense Report~n')
    ),
    print_report(HtmlMode, X, 0, 0).

main() :-
    print_report(true, [
        [dinner, 5000],
        [dinner, 5001],
        [breakfast, 1000],
        [breakfast, 1001],
        [car_rental, 4]
    ]).
