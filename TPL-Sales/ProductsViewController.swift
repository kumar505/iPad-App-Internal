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
    
    // MARK: Internal variables
    
    let fontSize: CGFloat = 17.0
    let data = ["Electrical", "Outdoor", "Yellow", "5", "300", "50", "150", "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        cell.gallery.setImage(UIImage(named: "camera-gray"), for: .normal)
        
        cell.firstYearPrice.attributedText = NSMutableAttributedString(string: "1st Year\nPrice ($)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        cell.firstYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Discounted\nPrice ($)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        cell.secondYearPrice.attributedText = NSMutableAttributedString(string: "2nd Year\nPrice ($)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        cell.secondYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Discounted\nPrice ($)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        
        cell.productName.setAttributedTitle(NSMutableAttributedString(string: (cell.productName.titleLabel?.text)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
        cell.location.setAttributedTitle(NSMutableAttributedString(string: (cell.location.titleLabel?.text)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
        cell.color.attributedText = NSMutableAttributedString(string: cell.color.text!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        cell.quantity.attributedText = NSMutableAttributedString(string: cell.quantity.text!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)])
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        
        cell.color.text = ""
        cell.gallery.setImage(UIImage(), for: .normal)
        
        cell.productName.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.productName.layer.borderWidth = 1
        cell.productName.layer.cornerRadius = 5
        cell.productName.layer.borderColor = ColorConstants.barBlue.cgColor
        cell.productName.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        cell.productName.addTarget(self, action: #selector(self.redirectToAddProduct), for: .touchUpInside)
        
        cell.location.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.location.layer.borderWidth = 1
        cell.location.layer.cornerRadius = 5
        cell.location.layer.borderColor = ColorConstants.barBlue.cgColor
        cell.location.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        cell.quantity.attributedText = NSMutableAttributedString(string: "Selected\n0")
        cell.firstYearPrice.attributedText = NSMutableAttributedString(string: "\nXXXXX")
        cell.firstYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "\nXXXXX")
        cell.secondYearPrice.attributedText = NSMutableAttributedString(string: "\nXXXXX")
        cell.secondYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "\nXXXXX")
        
        cell.productName.setTitle(" + Add a product", for: .normal)
        cell.location.setTitle(" + Add more products", for: .normal)
        
        cell.backgroundColor = ColorConstants.bgGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        cell.delegate = self
        cell.gallery.setImage(UIImage(named: "camera-blue-1"), for: .normal)
        cell.productName.setTitle(data[0], for: .normal)
        cell.location.setTitle(data[1], for: .normal)
        cell.color.text = data[2]
        cell.quantity.text = data[3]
        cell.firstYearPrice.text = data[4]
        cell.firstYearDiscountedPrice.text = data[5]
        cell.secondYearPrice.text = data[6]
        cell.secondYearDiscountedPrice.text = data[7]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            action, indexPath in
            print("Delete Swiped")
        }
        deleteAction.image = UIImage(named: "delete")
        
        let editAction = SwipeAction(style: .default, title: "Edit") {
            action, indexPath in
            print("Delete Swiped")
        }
        editAction.image = UIImage(named: "edit-white")
        editAction.backgroundColor = ColorConstants.buttonYellow
        
        if orientation == .right {
            return [deleteAction]
        } else {
            return [editAction]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: Internal functions
    
    func redirectToAddProduct() {
        self.performSegue(withIdentifier: "segueToAddProducts", sender: self)
    }
}
