import Quick
import Nimble
import swift_CashMoneyBlocks

class cashRegisterSpec: QuickSpec {
    override func spec() {

        var cashRegister : CashRegister = CashRegister()


        // Setup Test Data

        describe("applyCoupon Method", {
            it("should return the coupon discount of all transactions for a register", {
                // Add couponLogic
                expect(cashRegister.applyCoupons()).to(equal(13.66))
            })
        })
        describe("calculateTax Method",{
            it("should return the tax of all transactions for a register",{
                // Add taxLogic
                expect(cashRegister.calculateTax()).to(equal(2.999))
            })
        })
    }
}
