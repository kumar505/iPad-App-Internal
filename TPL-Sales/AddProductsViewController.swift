//
//  AddProductsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 16/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit
import SwipeCellKit

class AddProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SwipeTableViewCellDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var productLabels: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var add: UIBarButtonItem!
    @IBOutlet weak var addMoreProducts: UIButton!
    
    // MARK: Internal variables
    var rowsCount = 3
    var selectedProduct: ProductModel?
    var selectedColor: ProductColorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = ColorConstants.barBlue
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20.0),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        self.toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        self.toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        if rowsCount > 1 {
            self.navigationBar.topItem?.title = "Add more products"
        } else {
            addMoreProducts.isHidden = true
            self.navigationBar.topItem?.title = "Add a product"
        }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("Add", for: .normal)
        button.setImage(UIImage(named: "add-product"), for: .normal)
        button.setTitleColor(ColorConstants.barBlue, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.borderColor = ColorConstants.barBlue.cgColor
        button.layer.cornerRadius = 5
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        let barButtonItem = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolBar.items = [barButtonItem, flexibleSpace]
    }
    
    // MARK: Tableview delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if rowsCount > 1 {
            return 120
        }
        
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addProductsCell") as! AddProductsTableViewCell
        cell.delegate = self
        cell.selectProducts.delegate = self
        cell.selectColor.delegate = self
        if rowsCount > 1 {
            cell.parentStack.axis = .horizontal
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if rowsCount > 1 {
            guard orientation == .right else {
                return nil
            }
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
                action, indexPath in
            }
            deleteAction.image = UIImage(named: "delete")
            
            return [deleteAction]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: TextField delegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // UIStackView -> UIStackView -> UITableViewCellContentView -> AddProductsTableViewCell
        if let cell = textField.superview?.superview?.superview?.superview as? AddProductsTableViewCell {
            
            if cell.selectProducts == textField {
                performSegue(withIdentifier: "segueToPoductsDropDown", sender: cell)
                return false
            }
            if cell.selectColor == textField {
                performSegue(withIdentifier: "segueToColorDropDown", sender: cell)
                return false
            }
        }
        return true
    }
    
    // MARK: UnWind Segues
    
    @IBAction func unwindSegueFromSelectedProduct(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindSegueFromSelectedColor(_ segue: UIStoryboardSegue) {
        
    }
    
    // MARK: Actions
    
    @IBAction func performCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func performAdd(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func performAddMoreProducts(_ sender: UIButton) {
        rowsCount += 1
        productLabels.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToPoductsDropDown" {
            if let destPC = segue.destination.popoverPresentationController, let sourceView = sender as? UITableViewCell, let destVC = segue.destination as? ProductsDropDownTableViewController {
                destVC.selectedProduct = self.selectedProduct
                destPC.sourceRect = sourceView.bounds
            }
        }
        
        if segue.identifier == "segueToColorDropDown" {
            if let destPC = segue.destination.popoverPresentationController, let sourceView = sender as? UITableViewCell, let destVC = segue.destination as? ColorsDropDownTableViewController {
                destVC.selectedColor = self.selectedColor
                destPC.sourceRect = sourceView.bounds
            }
        }
    }
}
