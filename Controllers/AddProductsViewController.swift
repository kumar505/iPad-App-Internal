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
    @IBOutlet weak var addMoreProducts: UIButton!
    
    // MARK: Internal variables
    var rowsCount = 0
    var isMultipleAdd: Bool?
    var currentIndexPath: IndexPath?
    var selectedProduct: ProductModel?
    var selectedColor: ProductColorModel?
    var selectedProductEstimate: ProductEstimateModel?
    var selectedProductEstimateIndex: Int?
    var internalProductEstimates: [ProductEstimateModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = ColorConstants.barBlue
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
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
        button.addTarget(self, action: #selector(performAdd(_:)), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolBar.items = [barButtonItem, flexibleSpace]
        
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: Tableview delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if rowsCount > 1 && isMultipleAdd! {
            return 120
        }
        
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addProductsCell") as! AddProductsTableViewCell
        
        cell.selectProducts.delegate = self
        cell.selectColor.delegate = self
        cell.quantity.delegate = self
        cell.location.delegate = self
        
        cell.selectProducts.tag = 0
        cell.selectColor.tag = 1
        cell.quantity.tag = 2
        cell.location.tag = 3
        
        if rowsCount > 1 {
            cell.delegate = self
            cell.parentStack.axis = .horizontal
        } else {
            if self.selectedProductEstimate != nil {
                cell.selectProducts.text = selectedProductEstimate?.product?.name
                cell.selectColor.text = selectedProductEstimate?.color?.name
                cell.quantity.text = selectedProductEstimate?.quantity?.stringValue
                cell.location.text = selectedProductEstimate?.location
            }
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
        
        guard orientation == .right else {
            return nil
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            action, indexPath in
            print("Before: \(self.rowsCount)")
            self.rowsCount -= 1
            print("After: \(self.rowsCount)")
            if indexPath.section <= self.internalProductEstimates.count && self.internalProductEstimates.count != 0 {
                self.internalProductEstimates.remove(at: indexPath.section)
            }
            let indexSet = IndexSet(integer: indexPath.section)
            self.productLabels.deleteSections(indexSet, with: .automatic)
            action.fulfill(with: .reset)
        }
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // UIStackView -> UIStackView -> UITableViewCellContentView -> AddProductsTableViewCell
        if let cell = textField.superview?.superview?.superview?.superview as? AddProductsTableViewCell {
            
            currentIndexPath = productLabels.indexPath(for: cell)
            let estimate = ProductEstimateModel()
            if internalProductEstimates.count <= (currentIndexPath?.section)! {
                if selectedProductEstimate != nil {
                    internalProductEstimates.insert(selectedProductEstimate!, at: (currentIndexPath?.section)!)
                } else {
                    internalProductEstimates.insert(estimate, at: (currentIndexPath?.section)!)
                }
            }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let estimate = internalProductEstimates[(currentIndexPath?.section)!] as ProductEstimateModel
        let formatter = NumberFormatter()
        
        if textField.tag == 2 {
            if let inputValue = textField.text, inputValue != "" {
                estimate.quantity = formatter.number(from: textField.text!)
            } else {
                estimate.quantity = 0
            }
            if estimate.product?.price != nil {
                estimate.firstYearPrice = estimate.calculateFirstYearPrice()
                estimate.firstYearDiscPrice = estimate.calculateFirstYearDiscPrice()
                estimate.secondYearPrice = estimate.calculateSecondYearPrice()
                estimate.secondYearDiscPrice = estimate.calculateSecondYearDiscPrice()
            }
        }
        if textField.tag == 3 {
            if let inputValue = textField.text {
                estimate.location = inputValue
            }
        }
    }
    
    // MARK: UnWind Segues
    
    @IBAction func unwindSegueFromSelectedProduct(_ segue: UIStoryboardSegue) {
        
        if selectedProduct != nil {
            let cell = productLabels.cellForRow(at: currentIndexPath!) as? AddProductsTableViewCell
            cell?.selectProducts.text = selectedProduct?.name
            let estimate = internalProductEstimates[(currentIndexPath?.section)!]
            estimate.product = selectedProduct
            if estimate.quantity != nil {
                estimate.firstYearPrice = estimate.calculateFirstYearPrice()
                estimate.firstYearDiscPrice = estimate.calculateFirstYearDiscPrice()
                estimate.secondYearPrice = estimate.calculateSecondYearPrice()
                estimate.secondYearDiscPrice = estimate.calculateSecondYearDiscPrice()
            }
            
        }
    }
    
    @IBAction func unwindSegueFromSelectedColor(_ segue: UIStoryboardSegue) {
        
        if selectedColor != nil {
            let cell = productLabels.cellForRow(at: currentIndexPath!) as? AddProductsTableViewCell
            cell?.selectColor.text = selectedColor?.name
            internalProductEstimates[(currentIndexPath?.section)!].color = selectedColor
        }
    }
    
    // MARK: Actions
    
    @IBAction func performCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func performAdd(_ sender: UIButton) {
        internalProductEstimates = internalProductEstimates.filter {
            $0.product != nil && $0.color != nil && $0.quantity != nil && $0.location != nil
        }
        if selectedProductEstimateIndex != nil && internalProductEstimates.count > 0 {
            productsEstimate[selectedProductEstimateIndex!] = internalProductEstimates[0]
        } else {
            productsEstimate.append(contentsOf: internalProductEstimates)
        }
        performSegue(withIdentifier: "unwindWithAddProducts", sender: self)
    }
    
    @IBAction func performAddMoreProducts(_ sender: UIButton) {
        rowsCount += 1
        productLabels.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToPoductsDropDown" {
            if let destPC = segue.destination.popoverPresentationController, let sourceCell = sender as? AddProductsTableViewCell, let destVC = segue.destination as? ProductsDropDownTableViewController {
                destVC.selectedProduct = self.selectedProduct
                destPC.sourceView = sourceCell.firstStack
                destPC.sourceRect = sourceCell.selectProducts.frame
            }
        }
        
        if segue.identifier == "segueToColorDropDown" {
            if let destPC = segue.destination.popoverPresentationController, let sourceCell = sender as? AddProductsTableViewCell, let destVC = segue.destination as? ColorsDropDownTableViewController {
                destVC.selectedColor = self.selectedColor
                destPC.sourceView = sourceCell.secondStack
                destPC.sourceRect = sourceCell.selectColor.frame
            }
        }
    }
}
