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
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeSelector: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var dateSelector: UITextField!
    
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
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedOptionView.borderWidth = 0.5
        selectedOptionView.borderColor = UIColor.lightGray
        
        selectedOptionView.isHidden = true
        
        timeSelector.addRightView(imageName: "calender-time")
        dateSelector.addRightView(imageName: "calendar")
        
        showTimePicker(textField: timeSelector)
        showDatePicker(textField: dateSelector)
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
        
        if (cell.option.text?.contains("Full Specific Date"))! {
            selectedOptionView.isHidden = false
            time.isHidden = true
            timeSelector.isHidden = true
            date.isHidden = false
            dateSelector.isHidden = false
        } else if (cell.option.text?.contains("2 Part With Specific Date"))! {
            selectedOptionView.isHidden = false
            time.isHidden = false
            timeSelector.isHidden = false
            date.isHidden = false
            dateSelector.isHidden = false
        } else {
            selectedOptionView.isHidden = false
            date.isHidden = true
            dateSelector.isHidden = true
            time.isHidden = false
            timeSelector.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! InstallOptionTableViewCell
        cell.selectOption.setImage(UIImage(named: "select-inactive"), for: .normal)
        
        self.selectedOptionView.isHidden = true
    }
    
    // MARK: Internal functions
    
    func showDatePicker(textField: UITextField?) {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = ColorConstants.barBlue
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDatePicker(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneDatePicker(_:)))
        
        toolbar.setItems([cancel, flexibleSpace, done], animated: true)
        textField?.inputAccessoryView = toolbar
        textField?.inputView = datePicker
    }
    
    func showTimePicker(textField: UITextField?) {
        
        timePicker.datePickerMode = .time
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = ColorConstants.barBlue
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTimePicker(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneTimePicker(_:)))
        
        toolbar.setItems([cancel, flexibleSpace, done], animated: true)
        textField?.inputAccessoryView = toolbar
        textField?.inputView = timePicker
    }
    
    @objc func doneDatePicker(_ sender: UIBarButtonItem) {
        dateSelector.text = formatDate(date: datePicker.date)
        dateSelector.resignFirstResponder()
    }
    
    @objc func cancelDatePicker(_ sender: UIBarButtonItem) {
        dateSelector.resignFirstResponder()
    }
    
    @objc func doneTimePicker(_ sender: UIBarButtonItem) {
       
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: timePicker.date)
        let hour = comp.hour
        let minute = comp.minute
        
        timeSelector.text = "\(String(describing: hour!)):\(String(describing: minute!))"
        timeSelector.resignFirstResponder()
    }
    
    @objc func cancelTimePicker(_ sender: UIBarButtonItem) {
        timeSelector.resignFirstResponder()
    }
}
