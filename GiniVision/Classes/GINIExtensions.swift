//
//  GINIExtensions.swift
//  GiniVision
//
//  Created by Peter Pult on 15/06/16.
//  Copyright © 2016 Gini GmbH. All rights reserved.
//

import UIKit
import AVFoundation

/**
 Returns an optional `UIImage` instance with the given `name` preferably from the client's bundle.
 
 - parameter name: The name of the image file without file extension.
 
 - returns: Image if found with name.
 */
internal func UIImageNamedPreferred(named name: String) -> UIImage? {
    if let clientImage = UIImage(named: name) {
        return clientImage
    }
    let bundle = NSBundle(forClass: GINIVision.self)
    return UIImage(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)
}

/**
 Returns a localized string resource preferably from the client's bundle.
 
 - parameter key:     The key to search for in the strings file.
 - parameter comment: The corresponding comment.
 
 - returns: String resource for the given key.
 */
internal func NSLocalizedStringPreferred(key: String, comment: String) -> String {
    let clientString = NSLocalizedString(key, comment: comment)
    if  clientString != key {
        return clientString
    }
    let bundle = NSBundle(forClass: GINIVision.self)
    return NSLocalizedString(key, bundle: bundle, comment: comment)
}

/**
 Returns a font object not dependend on the os version used. 
 Needed because `systemFontOfSize:weight:` is not available prior to iOS 8.2.
 
 - parameter weight: The weight of the font.
 - parameter size:   The size of the font.
 
 - returns: Always a font with the correct weight.
 */
internal func UIFontPreferred(weight: FontWeight, andSize size: CGFloat) -> UIFont {
    if #available(iOS 8.2, *) {
        return UIFont.systemFontOfSize(size, weight: weight.cgFloatValue)
    } else {
        let fontName = weight == .Regular ? "HelveticaNeue" : "HelveticaNeue-\(weight.stringValue)"
        let font = UIFont(name: fontName, size: size)
        return  font ?? UIFont.systemFontOfSize(size)
    }
}

internal enum FontWeight {
    case Thin, Light, Regular, Bold
    
    var stringValue: String {
        switch self {
        case .Thin:
            return "Thin"
        case .Light:
            return "Light"
        case .Regular:
            return "Regular"
        case .Bold:
            return "Bold"
        }
    }
    
    @available(iOS 8.2, *)
    var cgFloatValue: CGFloat {
        switch self {
        case .Thin:
            return UIFontWeightThin
        case .Light:
            return UIFontWeightLight
        case .Regular:
            return UIFontWeightRegular
        case .Bold:
            return UIFontWeightBold
        }
    }
}

// MARK: Extensions
internal extension UIViewController {
    
    class func addActiveConstraint(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat, priority: UILayoutPriority = 1000) {
        let constraint = NSLayoutConstraint(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
        addActiveConstraint(constraint, priority: priority)
    }
    
    class func addActiveConstraint(constraint: NSLayoutConstraint, priority: UILayoutPriority = 1000) {
        constraint.priority = priority
        constraint.active = true
    }
    
}

internal extension AVCaptureVideoOrientation {
    
    internal init(_ interface: UIInterfaceOrientation) {
        switch interface {
        case .PortraitUpsideDown: self = .PortraitUpsideDown
        case .LandscapeLeft: self = .LandscapeLeft
        case .LandscapeRight: self = .LandscapeRight
        default: self = .Portrait
        }
    }
    
    internal init?(_ device: UIDeviceOrientation?) {
        guard let orientation = device else { return nil }
        switch orientation {
        case .Portrait: self = .Portrait
        case .PortraitUpsideDown: self = .PortraitUpsideDown
        case .LandscapeLeft: self = .LandscapeRight
        case .LandscapeRight: self = .LandscapeLeft
        default: return nil
        }
    }
    
}

internal extension AVCaptureDevice {
    
    func setFlashModeSecurely(mode: AVCaptureFlashMode) {
        guard hasFlash && isFlashModeSupported(mode) else { return }
        guard case .Some = try? lockForConfiguration() else { return print("Could not lock device for configuration") }
        flashMode = mode
        unlockForConfiguration()
    }
    
}
