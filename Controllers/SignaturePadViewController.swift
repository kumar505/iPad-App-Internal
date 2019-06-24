//
//  SignaturePadViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 15/10/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class SignaturePadViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var signatureView: UIView!
    @IBOutlet weak var signatureNavBar: UINavigationBar!
    @IBOutlet weak var signatureToolBar: UIToolbar!
    @IBOutlet weak var signatureMainImage: UIImageView!
    @IBOutlet weak var signatureTempImage: UIImageView!
    @IBOutlet weak var signatureReset: UIBarButtonItem!
    @IBOutlet weak var signatureDone: UIBarButtonItem!
    @IBOutlet weak var signatureCancel: UIBarButtonItem!
    
    // MARK: Internal variables
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 3.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signatureNavBar.isTranslucent = false
        signatureNavBar.barTintColor = ColorConstants.barBlue
        signatureNavBar.tintColor = UIColor.white
        signatureNavBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
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
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContextWithOptions(signatureView.frame.size, false, 0.0)
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
    
    @IBAction func performSignatureReset(_ sender: UIBarButtonItem) {
        
        signatureTempImage.image = nil
    }
    
    @IBAction func performSignatureDone(_ sender: UIBarButtonItem) {
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(signatureMainImage.frame.size)
        signatureMainImage.image?.draw(in: CGRect(x: 0, y: 0, width: signatureView.frame.size.width, height: signatureView.frame.size.height), blendMode: .normal, alpha: 1.0)
        signatureTempImage.image?.draw(in: CGRect(x: 0, y: 0, width: signatureView.frame.size.width, height: signatureView.frame.size.height), blendMode: .normal, alpha: opacity)
        signatureTempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        performSegue(withIdentifier: "unwindWithSignaturePad", sender: self)
    }

    @IBAction func performSignatureCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindWithSignaturePad" {
            if let destVC = segue.destination as? PaymentViewController {
                destVC.signature = self.signatureTempImage.image
            }
        }
    }
}
