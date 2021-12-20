#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = type
    @amount = amount
  end
end

def printReport(html_mode, *expenses)
  total = 0
  mealExpenses = 0

  if html_mode
    puts <<END
<!DOCTYPE html>
<html lang="en">
<head>
<title>Expense Report #{Time.now}</title>
</head>
<body>
<h1>Expense Report #{Time.now}</h1>
END
  else
    puts "Expenses: #{Time.now}"
  end

  if html_mode
    puts <<END
<table>
<thead>
<tr><th scope="col">Tyep</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
</thead>
<tbody>
END
  end
  for expense in expenses
    if expense.type == :dinner || expense.type == :breakfast
      mealExpenses += expense.amount
    end
    expenseName = ""
    case expense.type
    when :breakfast
        expenseName = "Breakfast"
    when :dinner
        expenseName = "Dinner"
    when :car_rental
        expenseName = "Car Rental"
    end
    mealOverExpensesMarker = expense.type == :dinner && expense.amount > 5000 || expense.type == :breakfast && expense.amount > 1000 ? "X" : " "
    if html_mode
      puts "<tr><td>#{expenseName}</td><td>#{expense.amount}</td><td>#{mealOverExpensesMarker}</td></tr>"
    else
      puts "#{expenseName}\t#{expense.amount}\t#{mealOverExpensesMarker}"
    end
    total += expense.amount
  end
  if html_mode
    puts "</tbody>"
    puts "</table>"
  end

  if html_mode
    puts "<p>Meal Expenses: #{mealExpenses}</p>"
    puts "<p>Total Expenses: #{total}</p>"
  else
    puts "Meal Expenses: #{mealExpenses}"
    puts "Total Expenses: #{total}"
  end

  if html_mode
    puts "</body>"
    puts "</html>"
  end
end

printReport(
    true,
    Expense.new(:breakfast, 1000),
    Expense.new(:breakfast, 1001),
    Expense.new(:dinner, 5000),
    Expense.new(:dinner, 5001),
    Expense.new(:car_rental, 4),
)
