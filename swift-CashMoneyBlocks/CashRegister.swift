//
//  CashRegister.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

class CashRegister: NSObject {
    let store : Store
    let transactions : [Transaction]
    let taxLogic : (transaction : Transaction) -> Float
    let couponLogic : (transaction : Transaction) -> Float

    init (store: Store, taxLogic : (transaction : Transaction) -> Float, couponLogic : (transaction : Transaction) -> Float)
    {
        self.store = store
        self.taxLogic = taxLogic
        self.couponLogic = couponLogic
        self.transactions = [Transaction]()
    }

    func applyCoupons() -> Float
    {
        var totalSaved : Float = 0
        for transaction in transactions
        {
            let saved = self.couponLogic(transaction: transaction)
            totalSaved += saved
        }

        return totalSaved
    }

    func calculateTax() -> Float
    {
        var totalTax : Float = 0
        for transaction in transactions
        {
            let tax = self.taxLogic(transaction: transaction)
            totalTax += tax
        }

        return totalTax
    }

}
