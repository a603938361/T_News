//
//  OfflineTableViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/25.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class OfflineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequestData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

extension OfflineTableViewController{
    func getRequestData(){
        NetworkTool.loadHomeNewsTitleData { (data) in
            print("--------------")
            print(data)
        }
    }
}
