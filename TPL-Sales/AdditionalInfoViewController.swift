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
    @IBOutlet weak var guttersToggle: UISwitch!
    @IBOutlet weak var dogsToggle: UISwitch!
    @IBOutlet weak var llEstToggle: UISwitch!
    @IBOutlet weak var followUp: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.followUpDate.addRightView(imageName: "calender-time", widthPadding: 20)
    }
    
    // MARK: Actions
    
    @IBAction func performGutterToggle(_ sender: UISwitch) {
        
        if sender.isOn {
            self.gutters.isHidden = false
        } else {
            self.gutters.isHidden = true
        }
    }
    
    @IBAction func performDogToggle(_ sender: UISwitch) {
        
    }
    
    @IBAction func performLLEstToggle(_ sender: UISwitch) {
        
    }

    @IBAction func performFollowUpToggle(_ sender: UISwitch) {
        
        if sender.isOn {
            self.followUpDate.isHidden = false
        } else {
            self.followUpDate.isHidden = true
        }
    }
}
