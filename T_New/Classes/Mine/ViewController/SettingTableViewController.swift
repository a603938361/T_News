//
//  SettingTableViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/9.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import Kingfisher
class SettingTableViewController: UITableViewController {
    
    var dataSource: Array = [[SettingModel]]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCacheDataSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        
        let pPath = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: pPath!) as! [Any]
        for dicts in cellPlist {
            let arr = dicts as! [[String : Any]]
            
            var rows = [SettingModel]()
            for dict in arr {
                let setting = SettingModel.deserialize(from: dict)
                rows.append(setting!)
            }
            
            dataSource.append(rows)
        }
        tableView.t_register(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.t_dequeueReusableCell(indexPath: indexPath) as SettingCell
        
        let c = dataSource[indexPath.section]
        let cc = c[indexPath.row]
        cell.settingModel = cc
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        if row == 0 { //
            print("清除缓存")
            cleanCacheData()
        }
        if row == 6 {
            let offline = OfflineTableViewController()
            offline.hidesBottomBarWhenPushed = true
            offline.title = "离线下载"
            navigationController?.pushViewController(offline, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension SettingTableViewController{
    func getCacheDataSize(){
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskStorageSize { (res) in
            switch res {
            case .success(let num):
                print(num/1024/1024)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheData"), object: num/1024/1024)
                break
            case .failure( _):
                break
            }
        }
    }
    
    func cleanCacheData() {
        let alertCon = UIAlertController(title: "确定清除全部缓存", message: "", preferredStyle: .actionSheet)
        let alertAc = UIAlertAction(title: "确定", style: .destructive) { (res) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
        }
        
        alertCon.addAction(alertAc)
        present(alertCon, animated: true, completion: nil)
    }
    
}
