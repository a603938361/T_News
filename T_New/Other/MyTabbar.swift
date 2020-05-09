//
//  MyTabbar.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class MyTabbar: UITabBar {

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(publishButton)
        
        //changeModel
        NotificationCenter.default.addObserver(self, selector: #selector(changeModel), name: NSNotification.Name(rawValue: "changeModel"), object: nil)
    }
    
    @objc func changeModel() {
        print("changeModel")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let publishButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        btn.sizeToFit()
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = frame.width
        let h:CGFloat = 49
        
        publishButton.center = CGPoint(x: w/2, y: h/2 - 10)
        
        let bw = w * 0.2
        let bh = h
        let by = 0
        var idx = 0
        
        //UITabBarButton
        for item in subviews {
            if !item.isKind(of: NSClassFromString("UITabBarButton")!){continue}
            let bx = bw * (idx > 1 ? CGFloat(idx+1) : CGFloat(idx))
            item.frame = CGRect(x: bx, y: CGFloat(by), width: bw, height: bh)
            idx += 1
        }
    }
}
