//
//  AddProductsTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 16/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit
import SwipeCellKit

class AddProductsTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var selectProducts: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var selectColor: UITextField!
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
