//
//  ProductsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var products: UITableView!
    
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        cell.gallery.setImage(UIImage(named: "camera-gray"), for: .normal)
        cell.firstYearPrice.attributedText = NSMutableAttributedString(string: "1st Year\nPrice ($)")
        cell.firstYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Discounted\nPrice ($)")
        cell.secondYearPrice.attributedText = NSMutableAttributedString(string: "2nd Year\nPrice ($)")
        cell.secondYearDiscountedPrice.attributedText = NSMutableAttributedString(string: "Discounted\nPrice ($)")
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsContentStaticCell") as! ProductsContentTableViewCell
        
        cell.color.text = ""
        cell.gallery.setImage(UIImage(), for: .normal)
        
        cell.productName.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.productName.layer.borderWidth = 0.5
        cell.productName.layer.cornerRadius = 5
        cell.productName.layer.borderColor = ColorConstants.barBlue.cgColor
        cell.location.setTitleColor(ColorConstants.barBlue, for: .normal)
        cell.location.layer.borderWidth = 0.5
        cell.location.layer.cornerRadius = 5
        cell.location.layer.borderColor = ColorConstants.barBlue.cgColor
        
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

}
