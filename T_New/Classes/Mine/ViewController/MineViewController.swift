//
//  MineViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MineViewController: UITableViewController {
    
    private var disposeBag = DisposeBag()
    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    
    var scrollview = UIScrollView()
    
    lazy var headerView: NoLoginHeaderView = {
        let header = NoLoginHeaderView.headerView()
        return header
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.t_register(cell: MyOtherCell.self)
        tableView.t_register(cell: MyFollowCell.self)

        
        NetworkTool.loadMyCellData {
            self.sections = $0
            self.tableView.reloadData()
            NetworkTool.loadMyConcern { (res) in
                self.concerns = res
                let indexset = IndexSet(integer: 0)
                self.tableView.reloadSections(indexset, with: .automatic)
            }
        }
        
        headerView.moreLogin.rx.tap.subscribe(onNext:{
                [weak self] in
                    let moreLogin = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: Bundle.main)
                let vc = moreLogin.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
                    
                vc.modalSize = (.full, .full)
                self?.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}



extension MineViewController{
    

    
    func testRxSwift() {

        /// scrollview rx
        scrollview.rx.contentOffset.subscribe(onNext:{ contentOffset in
        }).disposed(by:disposeBag)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { (noti) in
            print(noti)
        }
        
        NotificationCenter.default.rx.notification(UIApplication.willTerminateNotification).subscribe(onNext:{
            data in
            print(data)
        }).disposed(by:disposeBag)
    }
}



extension MineViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let followCell = tableView.t_dequeueReusableCell(indexPath: indexPath) as MyFollowCell
            followCell.selectionStyle = .none
            followCell.leftLabel.text = "u关注"
            followCell.myConcerns = concerns
            followCell.myCellModel = sections[indexPath.section][indexPath.row]
            followCell.delegate = self;
            return followCell
        }
        let cell = tableView.t_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 150
        }
        return 44
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
        if indexPath.section == 2 && indexPath.row == 1 {
            let settingVC = SettingTableViewController()
            settingVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(settingVC, animated: true)
        }
    }
}


extension MineViewController : MyFollowCellDelegate {
    func clickCollowCell(concern: MyConcern) {
        print("clickCollowCell")
        print(concern)
        
        let userDetail = UserDetailViewController()
        userDetail.hidesBottomBarWhenPushed = true
        userDetail.title = concern.name
        userDetail.myConcern = concern
        navigationController?.pushViewController(userDetail, animated: true)
    }
}
