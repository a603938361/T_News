//
//  MineViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    
    var sections = [[MyCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        
        tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        
        
        NetworkTool.loadMyCellData { (sectionArr) in
            
            print(sectionArr.count)
            self.sections = sectionArr
            self.tableView.reloadData()
        }
    }
}


extension MineViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
        cell.selectionStyle = .none
        let section = sections[indexPath.section]
        let cellModel = section[indexPath.row]
        cell.textLabel?.text = cellModel.text
        cell.leftLabel.text = cellModel.text
        cell.rightLabel.text = cellModel.grey_text
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
