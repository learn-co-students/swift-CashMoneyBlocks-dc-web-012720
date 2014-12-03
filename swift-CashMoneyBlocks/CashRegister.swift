//
//  CashRegister.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

class CashRegister: NSObject {
    var store : Store?
    var transactions : [Transaction]
    var taxLogic : ((transaction : Transaction) -> Float)?
    var couponLogic : ((transaction : Transaction) -> Float)?

    convenience override init()
    {
        self.init(store: nil,taxLogic: nil,couponLogic: nil)
    }
    
    init (store: Store?, taxLogic : ((transaction : Transaction) -> Float)?, couponLogic : ((transaction : Transaction) -> Float)?)
    {
        self.store = store
        self.taxLogic = taxLogic
        self.couponLogic = couponLogic
        self.transactions = [Transaction]()
    }

    func applyCoupons() -> Float
    {
        var totalSaved : Float = 0
        for transaction in self.transactions
        {
            if self.couponLogic != nil
            {
                let saved = self.couponLogic!(transaction: transaction)
                totalSaved += saved
            }
        }

        return totalSaved
    }

    func calculateTax() -> Float
    {
        var totalTax : Float = 0
        for transaction in transactions
        {
            if self.taxLogic != nil
            {
                let tax = self.taxLogic!(transaction: transaction)
                totalTax += tax
            }
        }

        return totalTax
    }

}
