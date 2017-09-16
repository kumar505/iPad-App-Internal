//
//  AddProductsViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 16/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit
import SwipeCellKit

class AddProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var productLabels: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var add: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Tableview delegate functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addProductsCell") as! AddProductsTableViewCell
        cell.delegate = self
        
        let frame =  cell.secondStack.frame
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 20)
        bottomLayer.backgroundColor = UIColor.clear.cgColor
        cell.secondStack.layer.addSublayer(bottomLayer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else {
            return nil
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            action, indexPath in
            print("Delete Swiped")
        }
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: Actions
    
    @IBAction func performCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func performAdd(_ sender: UIBarButtonItem) {
        
    }
    
}
