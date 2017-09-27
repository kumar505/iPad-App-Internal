//
//  WorkOrderTypeModel.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 27/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Foundation

class WorkOrderTypeModel {
    
    var name: String?
    var id: NSNumber?
    
    func parseServerData(responseData: [NSDictionary]) {
        
        for eachResponse in responseData {
            
            let workOrder = WorkOrderTypeModel()
            if let name = eachResponse.object(forKey: "Name") as? String {
                workOrder.name = name
            }
            
            if let id = eachResponse.object(forKey: "Id") as? NSNumber {
                workOrder.id = id
            }
            workOrderTypes.append(workOrder)
        }
        
        workOrderTypes = workOrderTypes.sorted(by: {$0.id?.compare($1.id!) == .orderedAscending})
    }
}
