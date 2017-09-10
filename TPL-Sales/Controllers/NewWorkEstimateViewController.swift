//
//  NewWorkEstimateViewController.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 09/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import UIKit

class NewWorkEstimateViewController: UIViewController, UITextFieldDelegate, UIToolbarDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var menuSegment: UISegmentedControl!
    @IBOutlet weak var pageContainer: UIView!
    
    var pages = [UIViewController]()
    var pageController: UIPageViewController!
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.formatUI()
        self.navigationItem.formatLogo()
        
        self.navigationController?.toolbar.isHidden = true
        self.toolbarItems = formatToolBarItems(isPrevious: false)
        
        menuSegment.setTitle("New Work Estimate", forSegmentAt: 0)
        menuSegment.isUserInteractionEnabled = false
        
        pageController.delegate = self
        pageController.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let first: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "first")
        let second: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "second")
        
        pages.append(first)
        pages.append(second)
        
        pageController.setViewControllers([first], direction: .forward, animated: true, completion: nil)
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
    
}
