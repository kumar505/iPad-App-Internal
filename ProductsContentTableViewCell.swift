//
//  ProductsContentTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 14/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class ProductsContentTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var firstYearPrice: UILabel!
    @IBOutlet weak var firstYearDiscountedPrice: UILabel!
    @IBOutlet weak var secondYearPrice: UILabel!
    @IBOutlet weak var secondYearDiscountedPrice: UILabel!
    @IBOutlet weak var gallery: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.contentView.backgroundColor = ColorConstants.yellow
        }
    }

}
