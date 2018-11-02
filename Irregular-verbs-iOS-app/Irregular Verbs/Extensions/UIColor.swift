//
//  UIColor.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 24/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    /// Initialise the color with the the decimal code color red, green, blue value
    ///
    /// - Parameters:
    ///     - red: The decimal code for red value. (between 0 incl. and 256 excl.)
    ///     - green: The decimal code for green value. (between 0 incl. and 256 excl.)
    ///     - blue: The decimal code for blue value. (between 0 incl. and 256 excl.)
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(CFloat(red) / 255.0), green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Initialise the color with HEX code
    ///
    /// - Parameters:
    ///     - rgb: The HEX color code
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}






