//
//  WorkOrderTypeDropDownTableViewController.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 27/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class WorkOrderTypeDropDownTableViewController: UITableViewController {
    
    // MARK: Internal variables
    
    var selectedOption: WorkOrderTypeModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workOrderTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownListCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = workOrderTypes[indexPath.row].name
        cell.textLabel?.textColor = ColorConstants.textGray
        if selectedOption != nil {
            if selectedOption?.id == workOrderTypes[indexPath.row].id {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedOption = workOrderTypes[indexPath.row]
        self.performSegue(withIdentifier: "unwindWithSelectedType", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindWithSelectedType" {
            if let destVC = segue.destination as? NewWorkEstimateViewController {
                destVC.selectedWorkOrderType = self.selectedOption
            }
        }
    }
}
