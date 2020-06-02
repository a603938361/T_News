//
//  HuoShanViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class HuoShanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        loadData()
    }
    
}

extension HuoShanViewController {
    func loadData() {
        NetworkTool.loadHuoShanMovie { (res) in
            print(res)
        }
    }
}
