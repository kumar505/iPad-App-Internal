//
//  ProductsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit
import SwipeCellKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var products: UITableView!
    @IBOutlet weak var finalSubTotal: UILabel!
    @IBOutlet weak var finalTax: UILabel!
    @IBOutlet weak var firstYearGrandTotal: UILabel!
    @IBOutlet weak var discountSwitch: UISwitch!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountExpiryLabel: UILabel!
    @IBOutlet weak var secondYearTotalPrice: UILabel!
    @IBOutlet weak var finalDiscountedPrice: UILabel!
    @IBOutlet weak var finalStorageFee: UILabel!
    @IBOutlet weak var secondYearGrandTotal: UILabel!
    @IBOutlet weak var disclaimer: UILabel!
    @IBOutlet weak var pendingSale: UISwitch!
    
    // MARK: Internal variables
    
    let fontSize: CGFloat = 15.0
    var firstYearGT: Float = 0
    var firstYearDiscGT: Float = 0
    var secondYearGT: Float = 0
    var secondYearDiscGT: Float = 0
    var totalQuantity: Int = 0
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let discountLabelLength = discountLabel.text?.characters.count {
            
            let lastCharIndex = discountLabelLength - 1
            let range = NSRange(location: lastCharIndex, length: discountLabelLength - lastCharIndex)
            
            let originalString = discountLabel.text
            let attributedString = NSMutableAttributedString(string: originalString!)
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
            
            discountLabel.attributedText = attributedString
        }
        
        let originalString = discountExpiryLabel.text
        let attributedString = NSMutableAttributedString(string: originalString!)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 1))
        discountExpiryLabel.attributedText = attributedString
        
        let disclaimerOriginalString = disclaimer.text
        let disclaimerAttributedString = NSMutableAttributedString(string: disclaimerOriginalString!)
        disclaimerAttributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 10))
        disclaimer.attributedText = disclaimerAttributedString
        
        formatter.numberStyle = .currency
        formatter.paddingPosition = .afterPrefix
        formatter.allowsFloats = true
        
        calculateGrandTotal()
    }
    
    // MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if productsEstimate.count > 0 {
            return productsEstimate.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if productsEstimate.count == 0 {
            return 90
        }
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        cell.gallery.isHidden = true
        
        let firstYearString = "I Year\nPrice ($)"
        let firstYearMutableString = NSMutableAttributedString(string: firstYearString, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        cell.firstYearPrice.attributedText = firstYearMutableString
        cell.firstYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Disc.\nPrice ($)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        cell.secondYearPrice.attributedText = NSMutableAttributedString(string: "II Year\nPrice ($)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        cell.secondYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Disc.\nPrice ($)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        
        cell.productName.setAttributedTitle(NSMutableAttributedString(string: (cell.productName.titleLabel?.text)!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
        cell.location.setAttributedTitle(NSMutableAttributedString(string: (cell.location.titleLabel?.text)!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
        cell.color.attributedText = NSMutableAttributedString(string: cell.color.text!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        cell.quantity.attributedText = NSMutableAttributedString(string: cell.quantity.text!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)])
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        
        cell.color.text = ""
        cell.gallery.setImage(UIImage(), for: .normal)
        
        cell.productName.setTitle(" + Product", for: .normal)
        cell.productName.tag = 1
        cell.productName.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.productName.layer.borderWidth = 1
        cell.productName.layer.cornerRadius = 5
        cell.productName.layer.borderColor = ColorConstants.barBlue.cgColor
        cell.productName.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        cell.productName.addTarget(self, action: #selector(self.redirectToAddProduct), for: .touchUpInside)
        
        cell.location.setTitle(" + Products", for: .normal)
        cell.location.tag = 2
        cell.location.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.location.layer.borderWidth = 1
        cell.location.layer.cornerRadius = 5
        cell.location.layer.borderColor = ColorConstants.barBlue.cgColor
        cell.location.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        cell.location.addTarget(self, action: #selector(self.redirectToAddProduct), for: .touchUpInside)
        
        cell.quantity.attributedText = NSMutableAttributedString(string: "\(totalQuantity)")
        cell.firstYearPrice.text = "\(firstYearGT)"
        cell.firstYearDiscountedPrice.text = "\(firstYearDiscGT)"
        cell.secondYearPrice.text = "\(secondYearGT)"
        cell.secondYearDiscountedPrice.text = "\(secondYearDiscGT)"
        
        cell.backgroundColor = ColorConstants.bgGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if productsEstimate.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
            let estimate = productsEstimate[indexPath.row]
            cell.delegate = self
            cell.gallery.setImage(UIImage(named: "camera-blue-1"), for: .normal)
            cell.productName.setTitle(estimate.product?.name, for: .normal)
            cell.location.setTitle(estimate.location, for: .normal)
            cell.color.text = estimate.color?.name
            cell.quantity.text = "\(String(describing: estimate.quantity!))"
            cell.firstYearPrice.text = "\(String(describing: estimate.firstYearPrice!))"
            cell.firstYearDiscountedPrice.text = "\(String(describing: estimate.firstYearDiscPrice!))"
            cell.secondYearPrice.text = "\(String(describing: estimate.secondYearPrice!))"
            cell.secondYearDiscountedPrice.text = "\(String(describing: estimate.secondYearDiscPrice!))"
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "productsEmptyCell")
            cell?.textLabel?.text = "No Products Available"
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = ColorConstants.textGray
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right {
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
                action, indexPath in
                productsEstimate.remove(at: indexPath.row)
                action.fulfill(with: .reset)
                self.calculateGrandTotal()
            }
            deleteAction.image = UIImage(named: "delete")
            return [deleteAction]
            
        } else {
            
            let editAction = SwipeAction(style: .default, title: "Edit") {
                action, indexPath in
                self.performSegue(withIdentifier: "segueToAddProducts", sender: indexPath)
                action.fulfill(with: .reset)
            }
            editAction.image = UIImage(named: "edit-white")
            editAction.backgroundColor = ColorConstants.buttonYellow
            return [editAction]
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: Actions
    
    @IBAction func performDiscountSwitch(_ sender: UISwitch) {
        calculateGrandTotal()
    }
    // MARK: Unwind segues
    
    @IBAction func unwindSegueFromAddProducts(_ segue: UIStoryboardSegue) {
        calculateGrandTotal()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToAddProducts" {
            if let destVC = segue.destination as? AddProductsViewController {
                if let sender = sender as? UIButton {
                    if sender.tag == 1 {
                        destVC.rowsCount = 1
                        destVC.isMultipleAdd = false
                    } else {
                        destVC.rowsCount = 3
                        destVC.isMultipleAdd = true
                    }
                }
                if let sender = sender as? IndexPath {
                    destVC.selectedProductEstimate = productsEstimate[sender.row]
                    destVC.selectedProductEstimateIndex = sender.row
                    destVC.rowsCount = 1
                    destVC.isMultipleAdd = false
                }
            }
        }
    }
    
    // MARK: Internal functions
    
    @objc func redirectToAddProduct(sender: UIButton) {
        
        self.performSegue(withIdentifier: "segueToAddProducts", sender: sender)
    }
    
    func calculateGrandTotal(reload: Bool? = true) {
        
        var taxedAmount: Float = 0
        var firstYearTotal: Float = 0
        firstYearGT = 0
        firstYearDiscGT = 0
        secondYearGT = 0
        secondYearDiscGT = 0
        totalQuantity = 0
        
        formatter.currencyCode = "USD"
        
        for eachEstimate in productsEstimate {
            firstYearGT += eachEstimate.firstYearPrice!
            firstYearDiscGT += eachEstimate.firstYearDiscPrice!
            secondYearGT += eachEstimate.secondYearPrice!
            secondYearDiscGT += eachEstimate.secondYearDiscPrice!
            totalQuantity += (eachEstimate.quantity?.intValue)!
        }
        
        if discountSwitch.isOn {
            firstYearTotal = firstYearDiscGT
        } else {
            firstYearTotal = firstYearGT
        }
        
        taxedAmount = (firstYearTotal * (tax / 100))
        finalSubTotal.text = formatter.string(for: firstYearTotal)
        finalTax.text = formatter.string(for: taxedAmount)
        firstYearGrandTotal.text = formatter.string(for: firstYearTotal + taxedAmount)
        
        secondYearTotalPrice.text = formatter.string(for: secondYearGT)
        finalDiscountedPrice.text = formatter.string(for: secondYearDiscGT)
        finalStorageFee.text = formatter.string(for: storageFee)
        secondYearGrandTotal.text = formatter.string(for: (Float(secondYearDiscGT) + Float(storageFee)))
        
        if reload! {
            products.reloadData()
        }
    }
}
