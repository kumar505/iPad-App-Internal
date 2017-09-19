//
//  AdditionalInfoViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class AdditionalInfoViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var amps: UITextField!
    @IBOutlet weak var breakerLocation: UITextField!
    @IBOutlet weak var gutters: UITextField!
    @IBOutlet weak var followUpDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.followUpDate.addRightView(imageName: "calender-time", widthPadding: 20)
    }

}
