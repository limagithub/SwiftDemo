//
//  UIColor+Extension.swift
//  SwiftDemo
//
//  Created by ZHL on 2018/11/8.
//  Copyright © 2018 zhanghailu. All rights reserved.
//

import UIKit

/*
 * Swift 4 与 3 的语法区别
 * let newStr = String(str[..<index]) // = str.substring(to: index) In Swift 3
 * let newStr = String(str[index...]) // = str.substring(from: index) In Swif 3
 * let newStr = String(str[range]) // = str.substring(with: range) In Swift 3
 */

extension UIColor {
    
    class func colorWithHexString(hex:String) ->UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
           // cString = cString.substring(from: index)
            cString = String(cString[index...])
        }
        
        if (String(cString).count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[..<rIndex])//cString.substring(to: rIndex)
        let otherString = String(cString[rIndex...])//cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = String(otherString[..<gIndex])//otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = String(cString[..<bIndex])//cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    

}
