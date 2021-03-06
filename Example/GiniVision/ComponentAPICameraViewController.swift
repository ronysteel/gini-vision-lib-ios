//
//  ComponentAPICameraViewController.swift
//  GiniVision
//
//  Created by Peter Pult on 16/06/2016.
//  Copyright © 2016 Gini. All rights reserved.
//

import UIKit
import GiniVision

/**
 View controller showing how to implement the camera using the Component API of the Gini Vision Library for iOS.
 */
class ComponentAPICameraViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    var contentController = UIViewController()
    
    private var imageData: NSData?
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*************************************************************************
         * CAMERA SCREEN OF THE COMPONENT API OF THE GINI VISION LIBRARY FOR IOS *
         *************************************************************************/
        
        // 1. Create and set a custom configuration object needs to be done once before using any component of the Component API.
        let giniConfiguration = GINIConfiguration()
        giniConfiguration.debugModeOn = true
        GINIVision.setConfiguration(giniConfiguration)
        
        // 2. Create the camera view controller
        contentController = GINICameraViewController(success:
            { imageData in
                self.imageData = imageData
                dispatch_async(dispatch_get_main_queue(), { 
                    self.performSegueWithIdentifier("showReview", sender: self)
                })
            }, failure: { error in
                print("Component API camera view controller received error:\n\(error)")
            })
        
        // 3. Display the camera view controller
        displayContent(contentController)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Displays the content controller inside the container view
    func displayContent(controller: UIViewController) {
        self.addChildViewController(controller)
        controller.view.frame = self.containerView.bounds
        self.containerView.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
    }
    
    // MARK: User actions
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showReview" {
            if let imageData = imageData,
               let vc = segue.destinationViewController as? ComponentAPIReviewViewController {
                vc.imageData = imageData
            }
        }
    }

}

