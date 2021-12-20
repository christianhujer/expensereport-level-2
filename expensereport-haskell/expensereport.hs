import Control.Monad (forM_)
import Data.Array
import Data.IORef

data ExpenseType = Dinner | Breakfast | CarRental

data Expense = Expense { eType :: ExpenseType, amount :: Int }

printReport :: Bool -> [Expense] -> IO ()
printReport htmlMode expenses = do
    total <- newIORef 0
    mealExpenses <- newIORef 0
    if htmlMode
        then do
            putStrLn("<!DOCTYPE html>")
            putStrLn("<html lang=\"en\">")
            putStrLn("<head>")
            putStrLn("<title>Expense Report</title>")
            putStrLn("</head>")
            putStrLn("<body>")
            putStrLn("<h1>Expense Report</h1>")
        else putStrLn("Expense Report")

    if htmlMode
        then do
            putStrLn "<table>"
            putStrLn "<thead>"
            putStrLn "<tr><th scope=\"col\">Type</th><th scope=\"col\">Amount</th><th scope=\"col\">Over Limit</th></tr>"
            putStrLn "</thead>"
            putStrLn "<tbody>"
        else pure ()

    forM_ expenses $ \expense -> do
        modifyIORef mealExpenses (+ (
            case (eType expense) of
                    Dinner -> (amount expense)
                    Breakfast -> (amount expense)
                    _ -> 0
            ))
        let expenseName = "" ++ case (eType expense) of
                Dinner    -> "Dinner"
                Breakfast -> "Breakfast"
                CarRental -> "Car Rental"
        let mealOverExpensesMarker = case (eType expense) of
                Dinner -> if (amount expense) > 5000 then "X" else " "
                Breakfast -> if (amount expense) > 1000 then "X" else " "
                _ -> " "
        if htmlMode
            then
                putStrLn("<tr><td>" ++ expenseName ++ "</td><td>" ++ (show (amount expense)) ++ "</td><td>" ++ mealOverExpensesMarker ++ "</td></tr>")
            else
                putStrLn(expenseName ++ "\t" ++ (show (amount expense)) ++ "\t" ++ mealOverExpensesMarker)
        modifyIORef total (+ (amount expense))
    if htmlMode
        then do
            putStrLn "</tbody>"
            putStrLn "</table>"
        else pure ()

    if htmlMode
        then do
            putStr("<p>Meal expenses: ")
            readIORef mealExpenses >>= print
            putStrLn("</p>")
            putStr("<p>Total expenses: ")
            readIORef total >>= print
            putStrLn("</p>")
        else do
            putStr("Meal expenses: ")
            readIORef mealExpenses >>= print
            putStr("Total expenses: ")
            readIORef total >>= print

    if htmlMode
        then do
            putStrLn "</body>"
            putStrLn "</html>"
        else pure ()

main :: IO ()
main = do
    printReport True ([
        Expense Breakfast 1000,
        Expense Breakfast 1001,
        Expense Dinner 5000,
        Expense Dinner 5001,
        Expense CarRental 4
        ])
