//
//  Util.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 09/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

// MARK: Right bar button UI

func rightUserBarButtonViewItem(title: String, subTitle: String, image: UIImage? = UIImage(named: "avatar") , rect: CGRect) -> UIView {
    
    let rightView = UIView(frame: CGRect(x: 0, y: 0, width: (rect.width/3), height: rect.height - 5))
    let rightViewWidth = rightView.frame.size.width
    let rightViewHeight = rightView.frame.size.height

    let rightLabelView = UIView(frame: CGRect(x: 0, y: 0, width: (rightViewWidth - (rect.height + 5)), height: rightViewHeight))
    let rightLabelViewWidth = rightLabelView.frame.size.width
    let rightLabelViewHeight = rightLabelView.frame.size.height
    
    let rightTitle = UILabel(frame: CGRect(x: 0, y: 0, width: rightLabelViewWidth, height: rightLabelViewHeight/2))
    rightTitle.text = title
    rightTitle.textColor = UIColor.white
    rightTitle.textAlignment = .right
    rightTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
    rightTitle.lineBreakMode = .byTruncatingTail
    
    let rightSubTitle = UILabel(frame: CGRect(x: 0, y: rightTitle.frame.height, width: rightLabelViewWidth, height: rightLabelViewHeight/2))
    rightSubTitle.text = subTitle
    rightSubTitle.textColor = UIColor.white
    rightSubTitle.textAlignment = .right
    rightSubTitle.font = UIFont.systemFont(ofSize: 15.0)
    rightSubTitle.lineBreakMode = .byTruncatingTail
    
    let rightImageView = UIImageView(frame: CGRect(x: rightLabelViewWidth + 5, y: 0, width: rightViewHeight, height: rightViewHeight))
    rightImageView.image = image
    rightImageView.layer.cornerRadius = rightImageView.frame.size.width/2
    rightImageView.clipsToBounds = true
    
    rightView.addSubview(rightTitle)
    rightView.addSubview(rightSubTitle)
    rightView.addSubview(rightImageView)
    
    return rightView
}

// MARK: BarButtonItem with custom button

func formBarButtonItem(title: String, imageName: String, bgColor: UIColor, semantic: UISemanticContentAttribute? = .forceLeftToRight) -> UIBarButtonItem {
    
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    button.layer.cornerRadius = 15
    button.semanticContentAttribute = semantic!
    switch semantic! {
    case UISemanticContentAttribute.forceRightToLeft:
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    case UISemanticContentAttribute.forceLeftToRight:
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    default:
        break
    }
    button.setTitle(title, for: .normal)
    button.backgroundColor = bgColor
    button.setImage(UIImage(named: imageName), for: .normal)
    
    let barButtonItem = UIBarButtonItem(customView: button)
    return barButtonItem
}

// MARK: ToolBar items

func formatToolBarItems(isPrevious: Bool? = false) -> [UIBarButtonItem] {
    
    let next = formBarButtonItem(title: "Next", imageName: "next", bgColor: ColorConstants.barBlue, semantic: UISemanticContentAttribute.forceRightToLeft)
    let previous = formBarButtonItem(title: "Previous", imageName: "previous", bgColor: ColorConstants.barBlue)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancel = formBarButtonItem(title: "Cancel", imageName: "cancel", bgColor: ColorConstants.buttonGray)
    
    if isPrevious! {
        return [previous, flexibleSpace, cancel, next]
    } else {
        return [flexibleSpace, cancel, next]
    }
    
}

// MARK: Utility functions

func formatDate(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: date)
}
