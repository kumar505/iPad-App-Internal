//
//  InstallOptionViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class InstallOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var options: UITableView!
    @IBOutlet weak var selectedOptionView: UIView!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var startDateSelector: UITextField!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var endDateSelector: UITextField!
    
    // MARK: Internal variables
    
    let optionList = [
        "2 Part",
        "Full Early",
        "Full First Half Only",
        "Full Specific Date With Discount",
        "2 Part With Specific Date",
        "Full Late",
        "Full Second Half Only",
        "Full Specific Date Without Discount"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedOptionView.borderWidth = 0.5
        self.selectedOptionView.borderColor = UIColor.lightGray
        
        self.selectedOptionView.isHidden = true
        
        self.startDateSelector.addRightView(imageName: "calender-time")
        self.endDateSelector.addRightView(imageName: "calender-time")
    }
    
    // MARK: Tableview delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "installOptionCell") as! InstallOptionTableViewCell
        cell.selectOption.setImage(UIImage(named: "select-inactive"), for: .normal)
        cell.option.text = optionList[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! InstallOptionTableViewCell
        cell.selectOption.setImage(UIImage(named: "select-active"), for: .normal)
        
        if indexPath.section == 4 {
            self.selectedOptionView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! InstallOptionTableViewCell
        cell.selectOption.setImage(UIImage(named: "select-inactive"), for: .normal)
        
        self.selectedOptionView.isHidden = true
    }
}
