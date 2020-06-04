//
//  HuoShanViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class HuoShanViewController: UIViewController {
    
    var tb:UITableView?
    var dataArr: [HuoShanModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        tb = UITableView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), style: .plain)
        tb?.dataSource = self
        tb?.delegate = self
        tb?.rowHeight = 230
        tb?.register(UINib(nibName: "HuoShanCell", bundle: nil), forCellReuseIdentifier: "HuoShanCell")
        view.addSubview(tb!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

extension HuoShanViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HuoShanCell", for: indexPath) as! HuoShanCell
        
        
        cell.huoShan = dataArr[indexPath.row]
        return cell;
    }
}

extension HuoShanViewController {
    func loadData() {
        NetworkTool.loadHuoShanMovie { (res) in
            print(res.count)
            self.dataArr = res
            self.tb?.reloadData()
        }
    }
}
