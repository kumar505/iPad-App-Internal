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
    @IBOutlet weak var signatureView: UIView!
    @IBOutlet weak var signatureToolBar: UIToolbar!
    @IBOutlet weak var signatureMainImage: UIImageView!
    @IBOutlet weak var signatureTempImage: UIImageView!
    @IBOutlet weak var signatureReset: UIBarButtonItem!
    @IBOutlet weak var signatureTitle: UIBarButtonItem!
    @IBOutlet weak var signatureDone: UIBarButtonItem!
    @IBOutlet weak var authorizationDesc: UITextView!
    
    // MARK: Internal variables
    var isAuthorized = false
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 3.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeesList.addRightView(imageName: "downarrow", widthPadding: 20)

        performCreditCard(creditCard)
    }
    
    // MARK: Drawing controller delegates
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: signatureView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: signatureView)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(signatureMainImage.frame.size)
        signatureMainImage.image?.draw(in: CGRect(x: 0, y: 0, width: signatureView.frame.size.width, height: signatureView.frame.size.height), blendMode: .normal, alpha: 1.0)
        signatureTempImage.image?.draw(in: CGRect(x: 0, y: 0, width: signatureView.frame.size.width, height: signatureView.frame.size.height), blendMode: .normal, alpha: opacity)
        signatureTempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        signatureTempImage.image = nil
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(signatureView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        signatureTempImage.image?.draw(in: CGRect(x: 0, y: 0, width: signatureView.frame.size.width, height: signatureView.frame.size.height))
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(.normal)
        
        context?.strokePath()
        
        signatureTempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        signatureTempImage.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    // MARK: Actions
    
    @IBAction func performPDF(_ sender: UIButton) {
        
    }
    
    @IBAction func performAuthorization(_ sender: UIButton) {
        
        if isAuthorized {
            authorize.setImage(UIImage(named: "checkbox-inactive"), for: .normal)
            isAuthorized = false
        } else {
            authorize.setImage(UIImage(named: "checkbox-active"), for: .normal)
            isAuthorized = true
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
    
    @IBAction func performSignatureReset(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func performSignatureDone(_ sender: UIBarButtonItem) {
    }

}
