//
//  Extensions.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 09/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

// MARK: UI Extensions

extension UITextField {
    
    func formatUI(imageName: String, borderColor: UIColor? = nil) {
        self.layer.cornerRadius = 5.0
        if borderColor != nil {
            self.layer.borderWidth = 1.0
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    func addLeftView(imageName: String? = nil) {
        if imageName != nil {
            self.leftViewMode = .always
            let imageView = UIImageView(image: UIImage(named: imageName!))
            if let size = imageView.image?.size {
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height)
                imageView.contentMode = .center
            }
            self.leftView = imageView
        }
    }
    
    func addRightView(imageName: String? = nil, widthPadding: CGFloat? = 10.0) {
        if imageName != nil {
            self.rightViewMode = .always
            let imageView = UIImageView(image: UIImage(named: imageName!))
            if let size = imageView.image?.size {
                imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + widthPadding!, height: size.height)
                imageView.contentMode = .center
            }
            self.rightView = imageView
        }
    }
}

extension UINavigationItem {
    
    func formatLogo() {
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        self.titleView = logo
    }
}

extension UINavigationController {
    
    func formatUI() {
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = ColorConstants.barBlue
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0),
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIToolbar {
    
    func formBarButtonItem(title: String, imageName: String, bgColor: UIColor) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        button.setTitle(title, for: .normal)
        button.backgroundColor = bgColor
        button.setImage(UIImage(named: imageName), for: .normal)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
    
    func formatUI(isPrevious: Bool? = false) {
        
        let next = self.formBarButtonItem(title: "Next", imageName: "next", bgColor: ColorConstants.barBlue)
        let previous = self.formBarButtonItem(title: "Previous", imageName: "previous", bgColor: ColorConstants.barBlue)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = self.formBarButtonItem(title: "Cancel", imageName: "cancel", bgColor: ColorConstants.buttonGray)
        
        if isPrevious! {
            self.items = [previous, flexibleSpace, cancel, next]
        } else {
            self.items = [flexibleSpace, cancel, next]
        }
        
    }
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

