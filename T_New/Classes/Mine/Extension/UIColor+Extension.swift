//
//  UIColor+Extension.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit


extension UIColor{
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(displayP3Red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    class func globalBackgroundColor() -> UIColor {
//        return UIColor(r: 248, g: 249, b: 247)
        return UIColor(r: 248, g: 249, b: 247)
    }
}
