//
//  UserHeaderDetailView.swift
//  T_New
//
//  Created by C.z on 2020/5/26.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class UserHeaderDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var touxiangImg: AnimatableImageView!
    @IBOutlet weak var toutiaoNum: UILabel!
    @IBOutlet weak var guanzhuNum: UILabel!
    @IBOutlet weak var fensiNum: UILabel!
    @IBOutlet weak var huozanNum: UILabel!
    
    @IBAction func guanzhuAction(_ sender: Any) {
        print("111111111")
    }
    @IBAction func sixinAction(_ sender: Any) {
        print("111111111")

    }
    
    @IBOutlet weak var guanzhuBtn: AnimatableButton!
    @IBOutlet weak var renzhengLabel: UILabel!
    @IBOutlet weak var renzhengH: NSLayoutConstraint!
    @IBOutlet weak var weizhiLabel: UILabel!
    @IBOutlet weak var jianjieLabel: UILabel!
    
    @IBOutlet weak var topScrollview: UIView!
    @IBOutlet weak var tableView: UITableView!
    var curBtn = UIButton()
    var dongtaiArr = [UDongtai]()
    
    //    var didSelectCellWithDongtai: ((_ dongtai: UserDetailDongtai)->())?

    var clickCell:((_ dingtai: UDongtai) -> ())?
    
    /**
     MyConcern(name: "安徽高速之声正午播报", url: "sslocal://profile?refer=all&user_id=1838011867206803&uid=1838011867206803&enter_from=my_follow", total_count: 0, description: "", time: "2020-05-10 16:07", type: "media", icon: "http://sf6-ttcdn-tos.pstatp.com/img/pgc-image/0e9e90dce4b24c6a994295f9ac3848d1~120x256.image", userid: 1838011867206803, is_verify: false, media_id: 0, tips: false, id: 1838011867206803, user_auth_info: T_New.UserAuthInfo(auth_type: 0, auth_info: ""))
     UserDetail(screen_name: "安徽高速之声正午播报", name: "安徽高速之声正午播报", big_avatar_url: "http://sf6-ttcdn-tos.pstatp.com/img/pgc-image/0e9e90dce4b24c6a994295f9ac3848d1~120x256.image", avatar_url: "http://sf6-ttcdn-tos.pstatp.com/img/pgc-image/0e9e90dce4b24c6a994295f9ac3848d1~120x256.image", status: 0, is_followed: false, is_following: true, current_user_id: 0, media_id: 1664098744053764, ugc_publish_media_id: 1664098744053764, user_id: 1838011867206803, creator_id: 1838011867206803, description: "安徽高速出行服务第一台", apply_auth_url: "sslocal://webview?url=https%3A%2F%2Fapi.snssdk.com%2Fuser%2Fprofile%2Fauth%2Fguide%2F&bounce_disable=1&hide_bar=1&title=", bg_img_url: "http://p3.pstatp.com/origin/bc30011684fa86d4b71", verified_content: "", user_verified: false, verified_agency: "", is_blocking: false, is_blocked: false, gender: 0, share_url: "https://m.toutiao.com/profile/1838011867206803/?version_code=&version_name=&device_platform=&share_version=2", followers_count: 7735, followings_count: 4, media_type: 7, area: "", user_auth_info: T_New.UserAuthInfo(auth_type: 0, auth_info: ""))
     */
    
    var userDetail:UserDetail? {
        didSet{
            
            touxiangImg.kf.setImage(with: URL(string: userDetail!.avatar_url))
            toutiaoNum.text = userDetail?.followersCount
            guanzhuNum.text = userDetail?.followingsCount
            renzhengLabel.text = userDetail?.verified_content
            jianjieLabel.text = userDetail?.description
            weizhiLabel.text = userDetail?.screen_name
            
            if (userDetail?.top_tab.count)! > 0 {
                topScrollview.addSubview(indicatorView)
                for (idx, tap) in userDetail!.top_tab.enumerated() {
                    
                    let btn = UIButton(frame: CGRect(x: CGFloat(idx) * 80, y:0, width: 80, height: 44))
                    btn.setTitle(tap.show_name, for: .normal)
                    btn.tag = idx
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
                    btn.setTitleColor(UIColor.black, for: .normal)
                    btn.setTitleColor(UIColor.red, for: .selected)
                    topScrollview.addSubview(btn)
                    if idx == 0 {
                        indicatorView.centerX = btn.centerX
                        btn.isSelected = true
                        curBtn = btn
                        
                        NetworkTool.loadUserDetailDongtaiList(userId: userDetail!.user_id, maxCursor: 0) { (cursor, userDetailDongtai) in
                            print(userDetailDongtai)
                        
                            self.dongtaiArr = userDetailDongtai
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.rowHeight = UITableView.automaticDimension
                            self.tableView.t_register(cell: DingTaiCell.self)
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dongtaiArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.t_dequeueReusableCell(indexPath: indexPath) as DingTaiCell
        cell.dongTaiData = self.dongtaiArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dongtaiArr[indexPath.row]
        clickCell?(model)
    }
    
    @objc func btnClick(btn: UIButton) {
        curBtn.isSelected = false
        btn.isSelected = !btn.isSelected
        
        UIView.animate(withDuration: 0.15, animations: {
            self.indicatorView.centerX = btn.centerX
        }) { (_) in
            self.curBtn = btn
        }
    }
    
    lazy var indicatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.topScrollview.frame.size.height - 2, width: 55, height: 2))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    class func headerDetailView() -> UserHeaderDetailView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserHeaderDetailView
    }
}


//extension UserHeaderDetailView{
//    func setTableView() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
//        }
//        cell?.textLabel?.text = "\(indexPath.row)"
//
//        return cell!
//    }
//}
