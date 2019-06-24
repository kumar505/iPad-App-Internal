//
//  ColorsDropDownTableViewController.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 28/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class ColorsDropDownTableViewController: UITableViewController {

    // MARK: Internal variables
    var selectedColor: ProductColorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productColors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorsDropDownListCell", for: indexPath)
        cell.textLabel?.text = productColors[indexPath.row].name
        cell.textLabel?.textColor = ColorConstants.textGray
        if selectedColor != nil {
            if selectedColor?.id == productColors[indexPath.row].id {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        performSegue(withIdentifier: "unwindWithSelectedColor", sender: cell)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindWithSelectedColor" {
            if let destVC = segue.destination as? AddProductsViewController, let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    destVC.selectedColor = productColors[indexPath.row]
                }
            }
        }
    }

}
