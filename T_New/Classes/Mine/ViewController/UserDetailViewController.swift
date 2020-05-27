//
//  UserDetailViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/26.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    var userHeaderDetail: UserDetail?
    var myConcern: MyConcern?
    
    lazy var userHeaderView: UserHeaderDetailView = {
        return UserHeaderDetailView.headerDetailView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.addSubview(userHeaderView)
        
        userHeaderView.clickCell = {[weak self] data in
            
            let detail = DongtaiDetailViewController()
            detail.hidesBottomBarWhenPushed = true
            detail.url = data.share_url
            detail.title = data.group.title
            self?.navigationController?.pushViewController(detail, animated: true)
        }
        loadRequest()
    }
}

extension UserDetailViewController {
    func loadRequest(){
        NetworkTool.loadUserDetail(userId: self.myConcern!.userid) { (res) in
            self.userHeaderDetail = res
            print(res)
            self.userHeaderView.userDetail = res
            self.scrollview.contentSize = CGSize(width: screenW, height: screenH)
        }
    }
}
