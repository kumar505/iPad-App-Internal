//
//  InstallOptionTableViewCell.swift
//  TPL-Sales
//
//  Created by Karthik Challa on 19/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class InstallOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var selectOption: UIButton!
    @IBOutlet weak var option: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.contentView.backgroundColor = ColorConstants.yellow
        } else {
            self.contentView.backgroundColor = UIColor.white
        }
    }

}
