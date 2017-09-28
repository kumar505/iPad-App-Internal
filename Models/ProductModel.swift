//
//  ProductModel.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 27/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Foundation

class ProductModel {
    
    var id: NSNumber?
    var name: String?
    var pullTicketName: String?
    var price: Double?
    var color: String?
    var location: String?
    var description: String?
    
    func parseServerData(responseData: [NSDictionary]) {
        
        for eachResponse in responseData {
            
            let product = ProductModel()
            if let name = eachResponse.object(forKey: "Name") as? String {
                product.name = name
            }
            
            if let id = eachResponse.object(forKey: "Id") as? NSNumber {
                product.id = id
            }
            
            if let pullTicketName = eachResponse.object(forKey: "PullTicketName") as? String {
                product.pullTicketName = pullTicketName
            }
            
            if let price = eachResponse.object(forKey: "Price") as? Double {
                product.price = price
            } else {
                product.price = 0
            }
            
            if let color = eachResponse.object(forKey: "Color") as? String {
                product.color = color
            }
            
            if let location = eachResponse.object(forKey: "Location") as? String {
                product.location = location
            }
            
            if let desc = eachResponse.object(forKey: "Description") as? String {
                product.description = desc
            }
            products.append(product)
        }
    }
}
