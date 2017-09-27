//
//  ProductColorModel.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 27/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Foundation

class ProductColorModel {
    
    var name: String?
    var id: NSNumber?
    
    func parseServerData(responseData: [NSDictionary]) {
        
        for eachResponse in responseData {
            
            let productColor = ProductColorModel()
            if let name = eachResponse.object(forKey: "Name") as? String {
                productColor.name = name
            }
            
            if let id = eachResponse.object(forKey: "Id") as? NSNumber {
                productColor.id = id
            }
            productColors.append(productColor)
        }
    }
}
