//
//  UITableView+Extension.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit


extension UITableView{
    
    func t_register<T: UITableViewCell>(cell:T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib{
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func t_dequeueReusableCell<T:UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
