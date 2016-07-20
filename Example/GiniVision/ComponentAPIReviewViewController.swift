//
//  ComponentAPIReviewViewController.swift
//  GiniVision
//
//  Created by Peter Pult on 21/06/2016.
//  Copyright © 2016 Gini. All rights reserved.
//

import UIKit
import GiniVision

class ComponentAPIReviewViewController: UIViewController {
    
    // Container attributes
    @IBOutlet var containerView: UIView!
    var contentController = UIViewController()
    
    // Input
    var imageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the review view controller
        contentController = GINIReviewViewController(imageData, success:
            { imageData in
                print("Component API review view controller received image data.")
                // Update current image data when image is rotated by user
                self.imageData = imageData
            }, failure: { error in
                print("Component API review view controller received error:\n\(error)")
            })
        
        // Display the review view controller
        displayContent(contentController)
    }
    
    // Pops back to the camera view controller
    @IBAction func back(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "giniShowAnalysis" {
            if let vc = segue.destinationViewController as? ComponentAPIAnalysisViewController {
                // Set image data as input for the analysis view controller
                vc.imageData = imageData
            }
        }
    }
    
    // Displays the content controller inside the container view
    func displayContent(_ controller: UIViewController) {
        self.addChildViewController(controller)
        controller.view.frame = self.containerView.bounds
        self.containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
}

