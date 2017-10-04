//
//  PaymentViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 11/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var paymentAmount: UITextField!
    @IBOutlet weak var balanceDue: UILabel!
    @IBOutlet weak var viewPDF: UIButton!
    @IBOutlet weak var creditCard: UIButton!
    @IBOutlet weak var chequePayment: UIButton!
    @IBOutlet weak var cashPayment: UIButton!
    @IBOutlet weak var paymentField1: UITextField!
    @IBOutlet weak var paymentField2: UITextField!
    @IBOutlet weak var paymentField3: UITextView!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var sendToCustomer: UISwitch!
    @IBOutlet weak var previouslyPaid: UILabel!
    @IBOutlet weak var employeesList: UITextField!
    @IBOutlet weak var authorize: UIButton!
    @IBOutlet weak var signature: UITextView!
    @IBOutlet weak var authorizationDesc: UITextView!
    
    // MARK: Internal variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeesList.addRightView(imageName: "downarrow", widthPadding: 20)

        performCreditCard(creditCard)
    }
    
    // MARK: Actions
    
    @IBAction func performPDF(_ sender: UIButton) {
        
    }
    
    @IBAction func performAuthorization(_ sender: UIButton) {
        
        if authorize.currentImage == UIImage(named: "checkbox-active") {
            authorize.setImage(UIImage(named: "checkbox-inactive"), for: .normal)
        } else {
            authorize.setImage(UIImage(named: "checkbox-active"), for: .normal)
        }
    }
    
    @IBAction func isSendToCustomer(_ sender: UISwitch) {
    
    }
    
    @IBAction func performCreditCard(_ sender: UIButton) {
        
        sender.setImage(UIImage(named: "creditcard-active"), for: .normal)
        sender.setTitleColor(ColorConstants.barBlue, for: .normal)
        sender.layer.borderColor = ColorConstants.barBlue.cgColor
        
        paymentField1.isHidden = false
        paymentField1.placeholder = "Name on the Card"
        paymentField2.isHidden = false
        paymentField2.isEnabled = true
        paymentField2.borderStyle = .roundedRect
        paymentField2.backgroundColor = UIColor.white
        paymentField2.placeholder = "Card Number"
        paymentField3.isHidden = true
        
        chequePayment.setImage(UIImage(named: "cheque-inactive"), for: .normal)
        chequePayment.setTitleColor(ColorConstants.textGray, for: .normal)
        chequePayment.layer.borderColor = UIColor.lightGray.cgColor
        cashPayment.setImage(UIImage(named: "cash-inactive"), for: .normal)
        cashPayment.setTitleColor(ColorConstants.textGray, for: .normal)
        cashPayment.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func performChequePayment(_ sender: UIButton) {
        
        sender.setImage(UIImage(named: "cheque-active"), for: .normal)
        sender.setTitleColor(ColorConstants.barBlue, for: .normal)
        sender.layer.borderColor = ColorConstants.barBlue.cgColor
        
        paymentField1.isHidden = false
        paymentField1.placeholder = "Cheque Number"
        paymentField2.isHidden = false
        paymentField2.isEnabled = false
        paymentField2.placeholder = ""
        paymentField2.borderStyle = .none
        paymentField2.backgroundColor = UIColor.clear
        paymentField3.isHidden = true
        
        creditCard.setImage(UIImage(named: "creditcard-inactive"), for: .normal)
        creditCard.setTitleColor(ColorConstants.textGray, for: .normal)
        creditCard.layer.borderColor = UIColor.lightGray.cgColor
        cashPayment.setImage(UIImage(named: "cash-inactive"), for: .normal)
        cashPayment.setTitleColor(ColorConstants.textGray, for: .normal)
        cashPayment.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func performCashPayment(_ sender: UIButton) {
        
        sender.setImage(UIImage(named: "cash-active"), for: .normal)
        sender.setTitleColor(ColorConstants.barBlue, for: .normal)
        sender.layer.borderColor = ColorConstants.barBlue.cgColor
        
        paymentField1.isHidden = true
        paymentField2.isHidden = true
        paymentField3.isHidden = false
        paymentField3.text = "Reason for cash payment"
        
        creditCard.setImage(UIImage(named: "creditcard-inactive"), for: .normal)
        creditCard.setTitleColor(ColorConstants.textGray, for: .normal)
        creditCard.layer.borderColor = UIColor.lightGray.cgColor
        chequePayment.setImage(UIImage(named: "cheque-inactive"), for: .normal)
        chequePayment.setTitleColor(ColorConstants.textGray, for: .normal)
        chequePayment.layer.borderColor = UIColor.lightGray.cgColor
    }

}
