//
//  GINIError.swift
//  GiniVision
//
//  Created by Peter Pult on 22/06/16.
//  Copyright © 2016 Gini. All rights reserved.
//

import UIKit

/**
 Errors thrown on the camera screen or during camera initialization.
 */
@objc public enum GINICameraError: Int, ErrorType {
    
    /// Unknown error during camera use.
    case Unknown = 0
    
    /// Camera can not be loaded because the user has denied authorization in the past.
    case NotAuthorizedToUseDevice
    
    /// No valid input device could be found for capturing.
    case NoInputDevice
    
    /// Capturing could not be completed.
    case CaptureFailed
    
}

/**
 Errors thrown on the review screen.
 */
@objc public enum GINIReviewError: Int, ErrorType {
    
    /// Unknown error during review.
    case Unknown = 0
    
}