//
//  UIColor+Extension.swift
//  Password Strength
//
//  Created by MacBook Pro on 11/9/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

// Utility methods to make UIColor work with hex color values
public extension UIColor {
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    
    class func colorFrom(hexString hexStr: String, alpha: CGFloat = 1) -> UIColor? {
        // 1. Make uppercase to reduce conditions
        var cStr = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased();
        
        // 2. Check if valid input
        let validRange = cStr.range(of: "\\b(0X|#)?([0-9A-F]{3,4}|[0-9A-F]{6}|[0-9A-F]{8})\\b", options: NSString.CompareOptions.regularExpression)
        if validRange == nil {
            print("Error: Inavlid format string: \(hexStr). Check documantation for correct formats", terminator: "")
            return nil
        }
        
        cStr = cStr.substring(with: validRange!)
        
        if(cStr.hasPrefix("0X")) {
            cStr = cStr.substring(from: cStr.index(cStr.startIndex, offsetBy: 2))
        } else if(cStr.hasPrefix("#")) {
            cStr = cStr.substring(from: cStr.index(cStr.startIndex, offsetBy: 1))
        }
        
        let strLen = cStr.count
        if (strLen == 3 || strLen == 4) {
            // Make it double
            var str2 = ""
            for ch in cStr {
                str2 += "\(ch)\(ch)"
            }
            cStr = str2
        } else if (strLen == 6 || strLen == 8) {
            // Do nothing
        } else {
            return nil
        }
        
        let scanner = Scanner(string: cStr)
        var hexValue: UInt32 = 0
        if scanner.scanHexInt32(&hexValue) {
            if cStr.count == 8 {
                let hex8: UInt32 = hexValue
                let divisor = CGFloat(255)
                let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
                let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
                let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
                let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)            }
            else {
                let hex6: UInt32 = hexValue
                let divisor = CGFloat(255)
                let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
                let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
                let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        } else {
            print("scan hex error")
        }
        
        return nil
    }
    
    /**
     Initializes a UIColor with a hex Int value
     
     - Parameter hex: The RGB hex Int value of the desired color
     - Parameter alpha: The alpha value of the color
     
     - Returns: A UIColor with the desired color
     */
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    /**
     Gets the hex value string of a UIColor
     
     - Returns: A String with the hex color value (e.g. "#ffffff" for UIColor.white)
     */
    var hexString: String {
        var R: CGFloat = 0
        var G: CGFloat = 0
        var B: CGFloat = 0
        var A: CGFloat = 0
        
        getRed(&R, green: &G, blue: &B, alpha: &A)
        
        let RGB = Int(Int((R * 255)) << 16) | Int(Int((G * 255)) << 8) | Int(Int((B * 255)) << 0)
        let hex = String(format: "#%06x", arguments: [RGB])
        
        return hex
    }
}

