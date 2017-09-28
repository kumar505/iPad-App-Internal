//
//  ProductEstimateModel.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 28/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Foundation

class ProductEstimateModel {
    
    var quantity: NSNumber?
    var product: ProductModel?
    var color: ProductColorModel?
    var location: String?
    var firstYearPrice: Double?
    var firstYearDiscPrice: Double?
    var secondYearPrice: Double?
    var secondYearDiscPrice: Double?
    
    func calculateFirstYearPrice() -> Double {
        
        // Quantity multiplied by unit price
        return ((self.product?.price)! * Double(truncating: self.quantity!))
    }
    
    func calculateFirstYearDiscPrice() -> Double {
        
        // 80% of the first year price
        return (self.firstYearPrice! * 0.8)
    }
    
    func calculateSecondYearPrice() -> Double {
        
        // 50% of the first year price
        return (self.firstYearPrice! * 0.5)
    }
    
    func calculateSecondYearDiscPrice() -> Double {
        
        // 40% of the first year price
        return (self.firstYearPrice! * 0.4)
    }
}
