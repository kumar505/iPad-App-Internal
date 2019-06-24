//
//  ServerIntegration.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 26/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Alamofire

func getWorkOrderTypes() {
    
    workOrderTypes.removeAll()
    
    toggleNetworkActivity(isOn: true)
    Alamofire.request(ServerAPI.getWorkOrderTypes).responseJSON { (response) in
        
        toggleNetworkActivity(isOn: false)
        switch response.result {
        case .success:
            if let responseData = response.result.value as? [NSDictionary] {
                
                let workOrderType = WorkOrderTypeModel()
                workOrderType.parseServerData(responseData: responseData)
                toggleNetworkActivity(isOn: false)
            }
        case .failure(let error):
            print(error)
        }
    }
}

func getProductColors() {
    
    productColors.removeAll()
    
    toggleNetworkActivity(isOn: true)
    Alamofire.request(ServerAPI.getProductColors).responseJSON { (response) in
        
        toggleNetworkActivity(isOn: false)
        switch response.result {
        case .success:
            if let responseData = response.result.value as? [NSDictionary] {
                
                let productColor = ProductColorModel()
                productColor.parseServerData(responseData: responseData)
            }
        case .failure(let error):
            print(error)
        }
    }
}

// Product Type = 1 for CH, 2 for LL, 3 for LL- Service, 4 for Event
func getProducts(id: String) {
    
    products.removeAll()
    
    let params = [
        "id": id
    ]
    
    toggleNetworkActivity(isOn: true)
    Alamofire.request(ServerAPI.getProductsListById, method: .get, parameters: params, encoding: URLEncoding.queryString).responseJSON { (response) in
        
        toggleNetworkActivity(isOn: false)
        switch response.result {
        case .success:
            if let data = response.result.value as? NSDictionary {
                if let responseData = data.object(forKey: "data") as? [NSDictionary] {
                    let product = ProductModel()
                    product.parseServerData(responseData: responseData)
                }
            }
        case .failure(let error):
            print(error)
        }
    }
}
