//
//  State.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

class State: NSObject {
    var name : String
    var abbreviation : String
    var cashRegister : CashRegister

    init(name : String, abbreviation : String, cashRegister : CashRegister)
    {
        self.name = name
        self.abbreviation = abbreviation
        self.cashRegister = cashRegister
    }

    func taxRate() -> Float
    {
        if self.abbreviation == "NY"
        {
            return 0.10
        }

        return 0.07
    }
}
