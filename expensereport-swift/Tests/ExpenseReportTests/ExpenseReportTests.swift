@testable import ExpenseReport
import XCTest

final class ExpenseReportTests: XCTestCase {
    func testPrintReport() throws {
        let expenseReport = ExpenseReport()
        expenseReport.printReport(
            htmlMode: true,
            expenses: [
                Expense(type: ExpenseType.breakfast, amount: 1000),
                Expense(type: ExpenseType.breakfast, amount: 1001),
                Expense(type: ExpenseType.dinner, amount: 5000),
                Expense(type: ExpenseType.dinner, amount: 5001),
                Expense(type: ExpenseType.carRental, amount: 4),
            ]
        )
    }
}
