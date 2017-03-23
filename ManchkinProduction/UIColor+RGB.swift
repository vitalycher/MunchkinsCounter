//
//  UIColor+RGB.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 17.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        
        assert(red >= 0 && red <= 255, "Wrong parameter for red")
        assert(green >= 0 && green <= 255, "Wrong parameter for green")
        assert(blue >= 0 && blue <= 255, "Wrong parameter for blue")
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func hex(string: String) -> UIColor {
        var cString:String = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
