//
//  NewWorkEstimateViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit
import Alamofire

class NewWorkEstimateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var selectType: UIButton!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var customerDetails: UITableView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var specialNotes: UITextView!
    @IBOutlet weak var salesNotes: UITextView!
    
    var isClicked = false
    
    // MARK: Internal Variables
    var selectedWorkOrderType: WorkOrderTypeModel?
    var custHeaders = [
        ["Name", "Email", "Primary Phone", "Primary Phone Type"],
        ["Alternate Email", "Alternate Phone", "Alternate Phone Type", "Keymap"],
        ["Address", "City", "Zipcode", "Gatecode"],
        ["Mailing Address", "City", "Zipcode", ""]
    ]
    var custDetailsJSON:[AnyHashable: Any] = [:]
    var custDetails: [[String]] = []
    
    var customerData = CustomerDataModel() {
        didSet {
//            custDetailsJSON = [
//                "Name":customerData.PrimaryName,
//                "Email":customerData.PrimaryEmail,
//                "Primary Phone":customerData.PrimaryPhone,
//                "Primary Type":customerData.PrimaryPhoneType,
//                "Alternate Email":customerData.Email,
//                "Alternate Phone":customerData.AltPhone,
//                "Alternate Phone Type":customerData.AltPhoneType,
//                "Keymap":customerData.KeyMap,
//                "Address":customerData.Address1,
//                "City":customerData.City,
//                "Zipcode":customerData.ZipCode,
//                "Gatecode": customerData.GateCode,
//                "Mailing Address":customerData.BillingAddress1,
//                "Mailing City":customerData.BillingCity,
//                "Mailing Zipcode":customerData.BillingZip
//            ]
            
            custDetails = [
                [customerData.PrimaryName, customerData.PrimaryEmail, customerData.PrimaryPhone, customerData.PrimaryPhoneType],
                [customerData.Email, customerData.AltPhone, customerData.AltPhoneType, customerData.KeyMap],
                [customerData.Address1, customerData.City, customerData.ZipCode, customerData.GateCode],
                [customerData.BillingAddress1, customerData.BillingCity, customerData.BillingZip, ""]
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notesView.isHidden = true
        self.customerDetails.tableFooterView = UIView()
        
        date.setTitle(formatDate(date: Date()), for: .normal)
        
        getCustomerDetails(Id: "8488")
    }
    
    // MARK: TableView delegates functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return custDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: "custHeader") as! CustHeaderTableViewCell
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "custDetails") as! FourColumnTableViewCell
        
        cell.column1_Item1.text = custHeaders[indexPath.row][0]
        cell.column2_Item1.text = custHeaders[indexPath.row][1]
        cell.column3_Item1.text = custHeaders[indexPath.row][2]
        cell.column4_Item1.text = custHeaders[indexPath.row][3]
        
        cell.column1_Item2.text = custDetails[indexPath.row][0]
        cell.column2_Item2.text = custDetails[indexPath.row][1]
        cell.column3_Item2.text = custDetails[indexPath.row][2]
        cell.column4_Item2.text = custDetails[indexPath.row][3]
        
        if indexPath.row == custDetails.count - 1 {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: cell.frame.size.width, bottom: 0, right: 0)
        }
        return cell
    }
    
    // MARK: Actions
    
    @IBAction func performSelectedType(_ sender: UIButton) {

        self.performSegue(withIdentifier: "segueToWorkOrderDropDown", sender: sender)
    }
    
    @IBAction func unwindSegueFromSelectedType(_ segue: UIStoryboardSegue) {
        
        if selectedWorkOrderType?.id == 1 {
            self.selectType.setTitle(selectedWorkOrderType?.name, for: .normal)
            persistNavigation(hidden: false)
        } else {
            self.selectType.setTitle(selectedWorkOrderType?.name, for: .normal)
            persistNavigation(hidden: true)
        }
        
        getProducts(id: "1")
    }
    
    func persistNavigation(hidden: Bool) {
        
        self.notesView.isHidden = hidden
        if let parentVC = self.parent?.parent as? WorkEstimateViewController {
            if hidden {
                parentVC.prepareInitialMenu()
            } else {
                parentVC.prepareNewWorkEstimateMenu()
            }
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToWorkOrderDropDown" {
            if let destPC = segue.destination.popoverPresentationController, let sourceView = sender as? UIButton, let destVC = segue.destination as? WorkOrderTypeDropDownTableViewController {
                destVC.selectedOption = self.selectedWorkOrderType
                destPC.sourceRect = sourceView.bounds
            }
        }
    }
    
    // MARK: Internal functions
    
    func getCustomerDetails(Id: String) {
        
        let params = [
            "id" : Id
        ]
        
        toggleNetworkActivity(isOn: true)
        Alamofire.request(ServerAPI.getCustomerDetails, method: .get, parameters: params, encoding: URLEncoding.queryString).responseJSON { (response) in
            
            toggleNetworkActivity(isOn: false)
            switch response.result {
            case .success:
                if let responseData = response.result.value as? NSDictionary {
                    
                    self.customerData = customer.parseServerData(response: responseData)
                    self.customerDetails.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
