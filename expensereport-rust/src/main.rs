use chrono;

enum ExpenseType {
    Dinner, Breakfast, CarRental
}

struct Expense {
    type_: ExpenseType,
    amount: i32,
}

fn print_report(html_mode: bool, expenses: &[Expense]) {
    let mut meal_expenses = 0;
    let mut total = 0;

    if html_mode {
        println!("<!DOCTYPE html>
<html lang=\"en\">
<head>
<title>Expense Report {}</title>
</head>
<body>
<h1>Expense Report {}</h1>", chrono::offset::Utc::now(), chrono::offset::Utc::now());
    } else {
        println!("Expense Report {}", chrono::offset::Utc::now());
    }

    if html_mode {
        println!("<table>
<thead>
<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>
</thead>
<tbody>");
    }
    for expense in expenses {
        match expense.type_ {
            ExpenseType::Dinner => meal_expenses += expense.amount,
            ExpenseType::Breakfast => meal_expenses += expense.amount,
            _ => (),
        }

        let expense_name: &str;
        match expense.type_ {
            ExpenseType::Dinner => expense_name = "Dinner",
            ExpenseType::Breakfast => expense_name = "Breakfast",
            ExpenseType::CarRental => expense_name = "Car Rental",
        }

        let meal_over_expenses_marker = if matches!(expense.type_, ExpenseType::Dinner) && expense.amount > 5000 || matches!(expense.type_, ExpenseType::Breakfast) && expense.amount > 1000 { "X" }  else { " " };

        if html_mode {
            println!("<tr><td>{}</td><td>{}</td><td>{}</td></tr>", expense_name, expense.amount, meal_over_expenses_marker);
        } else {
            println!("{}\t{}\t{}", expense_name, expense.amount, meal_over_expenses_marker);
        }
        total += expense.amount;
    }
    if html_mode {
        println!("</tbody>");
        println!("</table>");
    }

    if html_mode {
        println!("<p>Meal Expenses: {}</p>", meal_expenses);
        println!("<p>Total Expenses: {}</p>", total);
    } else {
        println!("Meal Expenses: {}", meal_expenses);
        println!("Total Expenses: {}", total);
    }

    if html_mode {
        println!("</body>");
        println!("</html>");
    }
}

fn main() {
    print_report(
        true,
        &[
            Expense { type_: ExpenseType::Breakfast, amount: 1000 },
            Expense { type_: ExpenseType::Breakfast, amount: 1001 },
            Expense { type_: ExpenseType::Dinner, amount: 5000 },
            Expense { type_: ExpenseType::Dinner, amount: 5001 },
            Expense { type_: ExpenseType::CarRental, amount: 4 },
        ]
    );
}

#[cfg(test)]
mod tests {
    #[test]
    fn characterize_print_report() {

    }
}
