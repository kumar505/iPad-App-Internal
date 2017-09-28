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
    private var currentIndex: Int?
    private var pendingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController.delegate = self
        pageController.dataSource = self
        
        getWorkOrderTypes()
        getProductColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.formatUI()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.formatLogo()
        
        self.navigationController?.toolbar.isHidden = true
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        self.toolbarItems = formatToolBarItems(isPrevious: false, target: self)
        
        menuSegmentView.backgroundColor = ColorConstants.barBlue
        
        menuSegment.isUserInteractionEnabled = false
        menuSegment.tintColor = UIColor.white
        menuSegment.backgroundColor = ColorConstants.barBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        prepareInitialMenu()
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
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                menuSegment.selectedSegmentIndex = index
                if index == pages.count - 1 {
                    self.toolbarItems = formatToolBarItems(isPrevious: true, nextTitle: "Save & Send", width: 150, target: self)
                } else if index == 0 {
                    self.toolbarItems = formatToolBarItems(isPrevious: false, target: self)
                } else {
                    self.toolbarItems = formatToolBarItems(isPrevious: true, target: self)
                }
            }
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex!
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
    
    @objc func performToolbar(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            // Cancel operation
            pages.removeAll()
            self.prepareInitialMenu()
            currentIndex = 0
            
        } else if sender.tag == 1 {
            
            // Previous operation
            pageController.goToPreviousPage()
            currentIndex! -= 1
        } else {
            
            // Next operation
            pageController.goToNextPage()
            currentIndex! += 1
        }
        
        if let index = currentIndex {
            menuSegment.selectedSegmentIndex = index
            if index == pages.count - 1 {
                self.toolbarItems = formatToolBarItems(isPrevious: true, nextTitle: "Save & Send", width: 150, target: self)
            } else if index == 0 {
                self.toolbarItems = formatToolBarItems(isPrevious: false, target: self)
            } else {
                self.toolbarItems = formatToolBarItems(isPrevious: true, target: self)
            }
        }

    }
    
    func prepareInitialMenu() {
        
        menuSegment.isHidden = true
        self.navigationController?.toolbar.isHidden = true
        
        let controllers = getControllers()
        menuSegment.removeAllSegments()
        if pages.count > 0 {
            if let range = Range.init(NSRange(location: 1, length: pages.count - 1)) {
                pages.removeSubrange(range)
            }
        } else {
            pages.append(controllers[0])
            menuSegment.insertSegment(withTitle: controllers[0].title, at: controllers.count, animated: true)
            pageController.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func prepareNewWorkEstimateMenu() {
    
        menuSegment.isHidden = false
        self.navigationController?.toolbar.isHidden = false
        
        var controllers = getControllers()
        menuSegment.removeAllSegments()
        menuSegment.insertSegment(withTitle: controllers[0].title, at: controllers.count, animated: true)
        controllers.removeFirst()
        
        for eachController in controllers {
            pages.append(eachController)
            menuSegment.insertSegment(withTitle: eachController.title, at: controllers.count, animated: true)
        }
        
        menuSegment.selectedSegmentIndex = 0
        currentIndex = 0
        
        pageController.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
    }
    
    func getControllers() -> [UIViewController] {
        
        let newWorkEstimate = storyboard?.instantiateViewController(withIdentifier: "newWorkEstimate") as! NewWorkEstimateViewController
        newWorkEstimate.title = "New Work Estimate"
        
        let products = storyboard?.instantiateViewController(withIdentifier: "products") as! ProductsViewController
        products.title = "Products"
        
        let installOption = storyboard?.instantiateViewController(withIdentifier: "installOption") as! InstallOptionViewController
        installOption.title = "Install Option"
        
        let additionalInfo = storyboard?.instantiateViewController(withIdentifier: "additionalInfo") as! AdditionalInfoViewController
        additionalInfo.title = "Additional Information"
        
        let payment = storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        payment.title = "Payment"
        
        let controllers = [newWorkEstimate, products, installOption, additionalInfo, payment]
        
        return controllers
    }
}
