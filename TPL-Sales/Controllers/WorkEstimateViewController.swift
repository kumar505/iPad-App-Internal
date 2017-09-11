//
//  WorkEstimateViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 09/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class WorkEstimateViewController: UIViewController, UITextFieldDelegate, UIToolbarDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var menuSegment: UISegmentedControl!
    @IBOutlet weak var pageContainer: UIView!
    @IBOutlet weak var menuSegmentView: UIView!
    
    var pages = [UIViewController]()
    var pageController: UIPageViewController!
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    let menuSegmentItems = ["New Work Estimate", "Products", "Install Option", "Additional Information", "Payment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.formatUI()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.formatLogo()
        
        self.navigationController?.toolbar.isHidden = true
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        self.toolbarItems = formatToolBarItems(isPrevious: false)
        
        menuSegmentView.backgroundColor = ColorConstants.barBlue
        
        menuSegment.isUserInteractionEnabled = false
        menuSegment.tintColor = UIColor.white
        menuSegment.backgroundColor = ColorConstants.barBlue
        
        menuSegmentView.isHidden = true
        
        pageController.delegate = self
        pageController.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.prepareMenu()
    }

    override func viewDidLayoutSubviews() {
        
        // Set right bar button item
        let leftView = rightUserBarButtonViewItem(title: "Title", subTitle: "SubTitle", rect: (self.navigationController?.navigationBar.frame)!)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: leftView)
    }
    
    // MARK: ToolBar Delegate functions
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return .topAttached
    }
    
    // MARK: TextField Delegate methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
    
    // MARK: Page View Controller delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == pages.count - 1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        pendingIndex = pages.index(of: pendingViewControllers.first!)
        if pendingIndex == pages.count - 1 {
            self.toolbarItems = formatToolBarItems(isPrevious: true, nextTitle: "Save & Send", width: 150)
        } else if pendingIndex == 0 {
            self.toolbarItems = formatToolBarItems(isPrevious: false)
        } else {
            self.toolbarItems = formatToolBarItems(isPrevious: true)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                menuSegment.selectedSegmentIndex = index
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func performMenuNavigation(_ sender: UISegmentedControl) {
        
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pageNavigationController" {
            if let destVC = segue.destination as? UIPageViewController {
                self.pageController = destVC
            }
        }
    }
    
    // MARK: Internal functions
    
    func prepareMenu() {
        
        let newWorkEstimate: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "newWorkEstimate")
        let products: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "products")
        let installOption: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "installOption")
        let additionalInfo: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "additionalInfo")
        let payment: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "payment")
        
        pages.append(newWorkEstimate)
        pages.append(products)
        pages.append(installOption)
        pages.append(additionalInfo)
        pages.append(payment)
        
        menuSegment.removeAllSegments()
        for item in menuSegmentItems {
            menuSegment.insertSegment(withTitle: item, at: menuSegmentItems.count, animated: true)
        }
        menuSegment.selectedSegmentIndex = 0
        
        pageController.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
    }
    
}
