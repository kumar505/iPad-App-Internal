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
    var firstYearPrice: Float?
    var firstYearDiscPrice: Float?
    var secondYearPrice: Float?
    var secondYearDiscPrice: Float?
    
    func calculateFirstYearPrice() -> Float {
        
        // Quantity multiplied by unit price
        return ((self.product?.price)! * Float(truncating: self.quantity!))
    }
    
    func calculateFirstYearDiscPrice() -> Float {
        
        // 80% of the first year price
        return (self.firstYearPrice! * 0.8)
    }
    
    func calculateSecondYearPrice() -> Float {
        
        // 50% of the first year price
        return (self.firstYearPrice! * 0.5)
    }
    
    func calculateSecondYearDiscPrice() -> Float {
        
        // 40% of the first year price
        return (self.firstYearPrice! * 0.4)
    }
}
