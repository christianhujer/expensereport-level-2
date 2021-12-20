(ns expensereport-clojure.core)

(defn expense [type amount] {:type type :amount amount})

(defn print-report
    [htmlMode expenses]
    (def total (atom 0))
    (def meal-expenses (atom 0))
    (if htmlMode
        (do
            (println "<!DOCTYPE html>")
            (println "<html lang=\"en\">")
            (println "<head>")
            (println "<title>Expense Report" (.toString (java.util.Date.)) "</title>")
            (println "</head>")
            (println "<body>")
            (println "<h1>Expense Report" (.toString (java.util.Date.)) "</h1>"))
        (println "Expense Report: " (.toString (java.util.Date.))))

    (if htmlMode
        (do
            (println "<table")
            (println "<thead>")
            (println "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>")
            (println "</thead>")
            (println "<tbody>")))
    (doall (for [expense (into #{} expenses)] (do
        (if (or (= (:type expense) :breakfast) (= (:type expense) :dinner)) (reset! meal-expenses (+ @meal-expenses (:amount expense))))
        (def expense-name (case (:type expense)
            :car-rental "Car Rental"
            :breakfast "Breakfast"
            :dinner "Dinner"))
        (def mealOverExpensesMarker (if (or (and (= (:type expense) :breakfast) (>= (:amount expense) 1000)) (and (= (:type expense) :dinner) (>= (:amount expense) 5000))) "X" " "))
        (if htmlMode
            (println "<tr><td>" expense-name "</td><td>" (:amount expense) "</td><td>" mealOverExpensesMarker "</td></tr>")
            (println expense-name "\t" (:amount expense) "\t" mealOverExpensesMarker))
        (reset! total (+ @total (:amount expense))))))
    (if htmlMode (do (println "</tbody>") (println "</table>")))
    (if htmlMode
        (do
            (println "<p>Meal expenses: " @meal-expenses "</p>")
            (println "<p>Total expenses: " @total "</p>"))
        (do
            (println "Meal expenses: " @meal-expenses)
            (println "Total expenses: " @total)))
    (if htmlMode (do (println "</body>") (println "</html>")))
)

(defn main []
    (print-report true [(expense :car-rental 100) (expense :breakfast 1000) (expense :breakfast 1001) (expense :dinner 5000) (expense :dinner 5001)])
)
