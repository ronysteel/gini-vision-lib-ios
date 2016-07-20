//
//  ComponentAPIAnalysisViewController.swift
//  GiniVision
//
//  Created by Peter Pult on 15/07/2016.
//  Copyright © 2016 Gini. All rights reserved.
//

import UIKit
import GiniVision

class ComponentAPIAnalysisViewController: UIViewController {
    
    // Container attributes
    @IBOutlet var containerView: UIView!
    var contentController = UIViewController()
    
    // User interface
    @IBOutlet var errorButton: UIButton!
    
    // Input
    var imageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide error button on load
        errorButton.alpha = 0.0
        
        // Create the analysis view controller
        contentController = GINIAnalysisViewController(imageData)
        
        // Display the analysis view controller
        displayContent(contentController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Starts loading animation
        (contentController as? GINIAnalysisViewController)?.showAnimation()
        
        displayError()
    }
    
    // Pops back to the review view controller
    @IBAction func back(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // Handle tap on error button
    @IBAction func errorButtonTapped(_ sender: AnyObject) {
        (contentController as? GINIAnalysisViewController)?.showAnimation()
        hideErrorButton()
        displayError()
    }
    
    // Display a random error notice
    func displayError() {
        delay(1.5) {
            (self.contentController as? GINIAnalysisViewController)?.hideAnimation()
            self.showErrorButton()
        }
    }
    
    // MARK: Toggle error button
    func showErrorButton() {
        guard errorButton.alpha != 1.0 else {
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.errorButton.alpha = 1.0
        }
    }
    
    func hideErrorButton() {
        guard errorButton.alpha != 0.0 else {
            return
        }
        UIView.animate(withDuration: 0.5) { 
            self.errorButton.alpha = 0.0
        }
    }
    
    // Displays the content controller inside the container view
    func displayContent(_ controller: UIViewController) {
        self.addChildViewController(controller)
        controller.view.frame = self.containerView.bounds
        self.containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    // Little delay helper by @matt
    func delay(_ delay:Double, closure:()->()) {
        DispatchQueue.main.after(
            when: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

}

