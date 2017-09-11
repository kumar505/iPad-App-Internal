//
//  FourColumnTableViewCell.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 12/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class FourColumnTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var column1_Item1: UILabel!
    @IBOutlet weak var column1_Item2: UILabel!
    @IBOutlet weak var column2_Item1: UILabel!
    @IBOutlet weak var column2_Item2: UILabel!
    @IBOutlet weak var column3_Item1: UILabel!
    @IBOutlet weak var column3_Item2: UILabel!
    @IBOutlet weak var column4_Item1: UILabel!
    @IBOutlet weak var column4_Item2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
