//
//  Transaction.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

class Transaction: NSObject {
    let product : Product
    let quantity : Int
    let fullTransactionValue : Float
    let dateOfTransaction : NSDate

    init(product : Product, quantity : Int, dateOfTransaction : NSDate?)
    {
        self.product = product
        self.quantity = quantity
        self.fullTransactionValue = product.price * Float(quantity)
        
        if dateOfTransaction == nil
        {
            self.dateOfTransaction = dateOfTransaction!

        } else
        {
            self.dateOfTransaction = NSDate()
        }
    }
}
