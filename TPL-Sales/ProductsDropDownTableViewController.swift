//
//  ProductsDropDownTableViewController.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 28/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class ProductsDropDownTableViewController: UITableViewController {

    // MARK: Internal variables
    var selectedProduct: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsDropDownListCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].name
        cell.textLabel?.textColor = ColorConstants.textGray
        if selectedProduct != nil {
            if selectedProduct?.id == products[indexPath.row].id {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        performSegue(withIdentifier: "unwindWithSelectedProduct", sender: cell)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unwindWithSelectedProduct" {
            if let destVC = segue.destination as? AddProductsViewController, let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    destVC.selectedProduct = products[indexPath.row]
                }
            }
        }
    }
}
