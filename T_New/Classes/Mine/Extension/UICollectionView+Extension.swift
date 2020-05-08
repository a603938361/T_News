//
//  UICollectionView+Extension.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit


extension UICollectionView{
    
    func t_register<T: UICollectionViewCell>(cell:T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib{
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func t_dequeueReusableCell<T:UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
