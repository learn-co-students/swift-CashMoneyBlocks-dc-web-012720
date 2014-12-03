//
//  Store.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

class Store: NSObject {
    let state : State
    let city : String
    let storeID : String
    let cashRegister : CashRegister
    let taxRate : Float

    init(state : State, city : String, storeID : String, cashRegister : CashRegister)
    {
        self.state = state
        self.city = city
        self.storeID = storeID
        self.cashRegister = cashRegister
        if self.state.abbreviation == "NY"
        {
            self.taxRate = 0.10;
        } else
        {
            self.taxRate = 0.07;
        }
    }

}
