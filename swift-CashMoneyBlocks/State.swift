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

    init(name : String, abbreviation : String)
    {
        self.name = name
        self.abbreviation = abbreviation
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
