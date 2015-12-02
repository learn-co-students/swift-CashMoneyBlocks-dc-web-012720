

# CashMoneyBlocks

## Instructions

**You are highly encouraged to read through the entire readme before attempting to do this lab!**

You are the lead software engineer for a manufacturer that makes the cash register hardware. Clients (e.g. Target, Walmart, Macys, Whole Foods) generally want to be able to program their cash registers after the fact to use their own receipt formats and program items into the register such that the pricing rules can change periodically (e.g. couponing, taxes, etc.)

As the manufacturer you do NOT want the `Retailer` to modify the cash register code itself, so you decide you are going to give them blocks as arguments for the methods that build the format of each transaction on the receipt so that they do not have to change anything in the register library itself.

The corporate office of a retailer will then program the logic for all the registers remotely, and each register will be assigned a store (which has a location, e.g. New York, New Jersey, Connecticut). Each store has just one register which logs all customer transactions.

To speed this process up a little, your junior developer has provided you with a basic `Product`, `Transaction`, `Store` and `State` class, complete with properties and initializers where needed.

As senior developer, you have to do the heavy lifting of the blocks. Ha. Ha. Ha.

Here is what you will need to do:

1) Build a `CashRegister` class with four properties including a store and a transactions array as well as two block properties. Since this is a lab on blocks, we'll let you figure out how to write those up. You'll want one for `couponLogic` and another for `taxLogic`.

This class will also have two methods called `applyCoupons` and `calculateTax`. They will both return an `Float` for the total dollars saved by using coupons and the total amount of tax for all transactions on the `CashRegister` respectively.

2) A test suite, which we have started for you. (Expected student response: Test practice too? Yes!!!)

The test suite should use the logic blocks for `taxLogic` and `couponLogic` provided below to ensure that your `CashRegister` object is working as expected. You will also need some test data, so we have included some code for you to cut and paste where appropriate in the test suite. We have also left you some hints on what to do in the test suite in the form of comments. But make sure you understand why you are placing the code in various places within the test suite!

If you've done it correctly, you will be given the total savings from coupons and the total tax collected of all transactions from each store, as the expect statements suggest.

####Tax Logic
```swift
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
```


####Coupon Logic
```swift
if transaction.product.category != ProductCategory.Education && transaction.fullTransactionValue > 10.0
{
    return transaction.fullTransactionValue * 0.10
}
return 0.0
```


####Transaction Data Code

```swift
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
```

## Notes

* Enums are used here to give numeric values more meaning. Therefore instead of using the number "1" to mean a product in the apparel category, we can use `ProductCategory.Apparel` instead. For more information, check out [this article](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)) on the various ways to declare ENUM.
* Check out the "switch" statements in our tax and coupon logic. They take the place of "if" statements as a conditional.
* In a real life scenario, we would likely have an array of products and their quantities as part of the `Transaction` object; but for today, we've chosen to simplify a bit for the sake of getting to the real point of this lab, which is blocks!
* In our contrived example, the tax gets applied to the items gross price (i.e. before the coupon discount gets applied). Feel free to try to get fancy and make them work together if you get this far!

<a href='https://learn.co/lessons/swift-CashMoneyBlocks' data-visibility='hidden'>View this lesson on Learn.co</a>

<a href='https://learn.co/lessons/swift-CashMoneyBlocks' data-visibility='hidden'>View this lesson on Learn.co</a>
