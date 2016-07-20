//
//  ComponentAPICameraViewController.swift
//  GiniVision
//
//  Created by Peter Pult on 16/06/2016.
//  Copyright © 2016 Gini. All rights reserved.
//

import UIKit
import GiniVision

class ComponentAPICameraViewController: UIViewController {
    
    // Container attributes
    @IBOutlet var containerView: UIView!
    var contentController = UIViewController()
    
    // Output
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and set a custom configuration object
        let giniConfiguration = GINIConfiguration()
        giniConfiguration.debugModeOn = true
        GINIVision.setConfiguration(giniConfiguration)
        
        // Create the camera view controller
        contentController = GINICameraViewController(success:
            { imageData in
                self.imageData = imageData
                DispatchQueue.main.async(execute: { () -> Void in
                    self.performSegue(withIdentifier: "giniShowReview", sender: self)
                })
            }, failure: { error in
                print("Component API camera view controller received error:\n\(error)")
            })
        
        // Display the camera view controller
        displayContent(contentController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // Go back to the API selection view controller
    @IBAction func back(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "giniShowReview" {
            if let imageData = imageData,
               let vc = segue.destinationViewController as? ComponentAPIReviewViewController {
                // Set image data as input for the review view controller
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

