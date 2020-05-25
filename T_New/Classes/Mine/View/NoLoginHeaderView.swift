//
//  NoLoginHeaderView.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import IBAnimatable

class NoLoginHeaderView: UIView {
    
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var qq: UIButton!
    @IBOutlet weak var wechat: UIButton!
    @IBOutlet weak var webo: UIButton!
    
    
    @IBOutlet weak var moreLogin: AnimatableButton!
    
    @IBAction func collectAction(_ sender: UIButton) {
        print("收藏")
    }
    @IBAction func historyAction(_ sender: Any) {
        print("历史")
    }
    @IBAction func nightAction(_ sender: Any) {
        print("夜间")
        
    }
    
    @objc func phoneClick() {
        print("手机登录")
    }
    @objc func qqClick() {
        print("QQ")
    }
    @objc func wechatClick() {
        print("微信")
    }
    @objc func weboClick() {
        print("微博")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        phone.addTarget(self, action: #selector(phoneClick), for: .touchUpInside)
        qq.addTarget(self, action: #selector(qqClick), for: .touchUpInside)
        wechat.addTarget(self, action: #selector(wechatClick), for: .touchUpInside)
        webo.addTarget(self, action: #selector(weboClick), for: .touchUpInside)
    }
    
    
    class func headerView() -> NoLoginHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! NoLoginHeaderView
    }
}
