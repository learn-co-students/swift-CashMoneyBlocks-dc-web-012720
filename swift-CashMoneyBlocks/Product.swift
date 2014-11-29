//
//  Product.swift
//  swift-CashMoneyBlocks
//
//  Created by Joe Burgess on 11/29/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit

enum ProductCategory
{
    case Undefined
    case Apparel
    case Grocery
    case Education
    case LuxuryItem
    case Other
}

class Product: NSObject {
    let productDescription : String
    let UPC : String
    let price : Float
    let measure : String
    let category : ProductCategory

    init(productDescription : String, upc : String, price : Float, measure : String, category : ProductCategory)
    {
        self.productDescription = productDescription
        self.UPC = upc
        self.price = price
        self.measure = measure
        self.category = category
    }
    
}
