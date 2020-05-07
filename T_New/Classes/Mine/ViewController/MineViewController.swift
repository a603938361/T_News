//
//  MineViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        
        NetworkTool.loadMyCellData { (sectionArr) in
            
            print(sectionArr.count)
            
            for item in sectionArr{
                
            }
        }
    }
}


extension MineViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "测试"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
}
