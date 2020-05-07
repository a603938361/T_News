//
//  TabBarController.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(tabBar.subviews)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.red
        tabbar.barTintColor = UIColor.white
        addChileVC()
        setValue(MyTabbar(), forKey: "tabBar")
    }
    
    func setAddChild(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        
        let nav = NavigationController(rootViewController: childController)
        addChild(nav)
    }
    
    func addChileVC() -> Void {
            setAddChild(HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        setAddChild(VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        setAddChild(HuoShanViewController(), title: "火山", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        setAddChild(MineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_")
    }
}
