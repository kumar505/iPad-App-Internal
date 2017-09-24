//
//  Constants.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 09/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

// App Delegate
var appDelegate = UIApplication.shared.delegate as! AppDelegate

struct ColorConstants {
    
    static var barBlue = UIColor(red: 5/255, green: 103/255, blue: 158/255, alpha: 1)
    static var textGray = UIColor(red: 95/255, green: 111/255, blue: 119/255, alpha: 1)
    static var bgGray = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    static var buttonGray = UIColor(red: 167/255, green: 169/255, blue: 172/255, alpha: 1)
    static var yellow = UIColor(red: 253/255, green: 251/255, blue: 222/255, alpha: 1)
    static var buttonYellow = UIColor(red: 246/255, green: 203/255, blue: 83/255, alpha: 1)
}

let products = "Products"
let installOption = "Install Option"
let additionalInfo = "Additional Information"
let payment = "Payment"

let workOrderTypes = [[products, installOption, additionalInfo, payment]]
