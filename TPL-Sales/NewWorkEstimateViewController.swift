//
//  NewWorkEstimateViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

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
    var custHeaders = [
        ["Name", "Email", "Primary Phone", "Primary Phone Type"],
        ["Alternate Email", "Alternate Phone", "Alternate Phone Type", "Keymap"],
        ["Address", "City", "Zipcode", "Gatecode"],
        ["Mailing Address", "City", "Zipcode", ""]
    ]
    var custDetails = [
        ["James", "zipcode@gmail.com", "(111) 111-111", "xxx"],
        ["zipcode@gmail.com", "(000) 000-000", "yyy", "UPDATE"],
        ["6301 Stonewood Dr", "Plano", "75024", " "],
        ["6301 Stonewood Dr", "Plano", "75024", ""],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customerDetails.tableFooterView = UIView()
        self.notesView.isHidden = true
        
        date.setTitle(formatDate(date: Date()), for: .normal)
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
        return cell
    }
    
    // MARK: Actions
    
    @IBAction func performSelectedType(_ sender: UIButton) {
        
        if isClicked {
            persistNavigation(hidden: true)
            isClicked = false
        } else {
            persistNavigation(hidden: false)
            isClicked = true
        }
    }
    
    func persistNavigation(hidden: Bool) {
        self.notesView.isHidden = hidden
        if let parentVC = self.parent?.parent as? WorkEstimateViewController {
            parentVC.menuSegmentView.isHidden = hidden
            parentVC.navigationController?.toolbar.isHidden = hidden
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
