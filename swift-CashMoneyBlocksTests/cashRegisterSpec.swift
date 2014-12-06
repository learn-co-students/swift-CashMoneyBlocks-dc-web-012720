import Quick
import Nimble
import swift_CashMoneyBlocks

class cashRegisterSpec: QuickSpec {
    override func spec() {

        var cashRegister : CashRegister = CashRegister()
        let newYork = State(name: "New York", abbreviation: "NY")

        beforeEach() {
            let apple = Product(productDescription: "Apple", upc: "0000000000415", price: 0.95, measure: "ea", category: ProductCategory.Grocery)
            let cereal  = Product(productDescription: "Cracklin' Oat Barn", upc: "0038000045310", price: 4.99, measure: "oz", category: ProductCategory.Grocery)
            let vanillaGoGurt  = Product(productDescription: "Vanilla GoGurt - To Stay, 7 oz", upc: "0038000045302", price: 1.99, measure: "oz", category: ProductCategory.Grocery)
            let sliceSoda  = Product(productDescription: "That soda you've probably heard of was once a competitor to Sprite", upc: "12000810060", price: 1.99, measure: "fl oz", category: ProductCategory.Grocery)
            let siliconValleyHoodie  = Product(productDescription: "Silicon Valley Hoodie - Size M", upc: "55000030387", price: 42.99, measure: "Mens Tee", category: ProductCategory.Apparel)
            let functionalProgrammingWithSwiftBook  = Product(productDescription: "Functional Programming in Swift", upc: "66611000000", price: 29.99, measure: "pages", category: ProductCategory.Education)

            let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
            let components = NSDateComponents()
            components.calendar = calendar
            components.year = 2014
            components.month = 5
            components.day = 12
            components.hour = 16
            components.minute = 1
            components.second = 12

            let date1 = calendar?.dateFromComponents(components)
            let transaction1 = Transaction(product: apple, quantity: 25, dateOfTransaction: date1)

            components.calendar = calendar
            components.year = 2014
            components.month = 6
            components.day = 12
            components.hour = 12
            components.minute = 0
            components.second = 1

            let date2 = calendar?.dateFromComponents(components)
            let transaction2 = Transaction(product: cereal, quantity: 14, dateOfTransaction: date2)

            let transaction3 = Transaction(product: vanillaGoGurt, quantity: 5, dateOfTransaction: date2)
            let transaction4 = Transaction(product: sliceSoda, quantity: 1, dateOfTransaction: date2)


            components.year = 2014
            components.month = 6
            components.day = 12
            components.hour = 12
            components.minute = 0
            components.second = 4

            let date3 = calendar?.dateFromComponents(components)
            let transaction5 = Transaction(product: siliconValleyHoodie, quantity: 1, dateOfTransaction: date3)

            components.year = 2014
            components.month = 6
            components.day = 12
            components.hour = 12
            components.minute = 0
            components.second = 10

            let date4 = calendar?.dateFromComponents(components)
            let transaction6 = Transaction(product: functionalProgrammingWithSwiftBook, quantity: 1, dateOfTransaction: date4)
            cashRegister = CashRegister()
            cashRegister.transactions = [transaction1,transaction2,transaction3,transaction4,transaction5,transaction6]
            let myStore = Store(state: newYork, city: "New York", storeID: "123", cashRegister: cashRegister)
            cashRegister.store = myStore
        }

        describe("applyCoupon Method", {
            it("should return the coupon discount of all transactions for a register", {
                cashRegister.couponLogic = { (transaction: Transaction) -> Float in
                    if transaction.product.category != ProductCategory.Education && transaction.fullTransactionValue > 10.0
                    {
                        return transaction.fullTransactionValue * 0.10
                    }
                    return 0.0;
                    }
                expect(cashRegister.applyCoupons()).to(equal(13.66))
            })
        })
        describe("calculateTax Method",{
            it("should return the tax of all transactions for a register",{
                cashRegister.taxLogic = { (transaction: Transaction) -> Float in
                    let taxAmount = transaction.product.price * cashRegister.store!.taxRate
                    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                    let components = NSDateComponents()
                    components.calendar = calendar
                    switch transaction.product.category
                    {
                    case ProductCategory.Grocery:
                        return 0.0
                    case ProductCategory.Apparel:
                         if cashRegister.store!.state.abbreviation == "NY" && transaction.product.price < 100.0
                         {
                            return 0.0
                        }
                        return taxAmount
                    case ProductCategory.Education:
                        components.year = 2014
                        components.month = 8
                        components.day = 1
                        components.hour = 0
                        components.minute = 0
                        components.second = 0

                        let startOfSchoolShopping = calendar!.dateFromComponents(components)

                        components.month = 9
                        components.day = 30
                        components.hour = 23
                        components.minute = 59
                        components.second = 59

                        let endOfSchoolShopping = calendar!.dateFromComponents(components)

                        if calendar?.compareDate(transaction.dateOfTransaction, toDate: startOfSchoolShopping!, toUnitGranularity: NSCalendarUnit.MinuteCalendarUnit) == NSComparisonResult.OrderedAscending && calendar?.compareDate(transaction.dateOfTransaction, toDate: endOfSchoolShopping!, toUnitGranularity: NSCalendarUnit.MinuteCalendarUnit) == NSComparisonResult.OrderedDescending
                        {
                            return 0.0
                        }
                        return taxAmount
                    case ProductCategory.LuxuryItem:
                        return taxAmount * 2.0
                    default:
                        return taxAmount
                    }
                }
                expect(cashRegister.calculateTax()).to(equal(2.999))
            })
        })
    }
}
