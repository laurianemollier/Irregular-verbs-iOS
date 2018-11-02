//
//  UIFont.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 24/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//


/// Sources: https://medium.com/@AttiaMo/custom-fonts-in-ios-apps-global-settings-and-localizations-e6193918e35c
import Foundation
import UIKit


// The basic font for the hole app
extension UIFont {
    
    /// The app font in bold
    ///
    /// - Parameters:
    ///     - size: the size of the font
    /// - Returns: The app font in bold
    class func  appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Bold", size: size)!
    }
    
    /// The app font in regular
    ///
    /// - Parameters:
    ///     - size: the size of the font
    ///
    /// - Returns: The app font in regular
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Regular", size: size)!
    }
    
    /// The app font in thin
    ///
    /// - Parameters:
    ///     - size: the size of the font
    ///
    /// - Returns: The app font in thin
    class func appThinFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Thin", size: size)!
    }
    
    /// The app font in light
    ///
    /// - Parameters:
    ///     - size: the size of the font
    ///
    /// - Returns: The app font in light
    class func appLightFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Light", size: size)!
    }
}

