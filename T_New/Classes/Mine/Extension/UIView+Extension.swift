
//
//  UIView+Extension.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {}

extension RegisterCellOrNib{
    static var identifier: String {
        return "\(self)"
    }
    
    static var nib: UINib?{
        return UINib(nibName: "\(self)", bundle: nil)
    }
}


