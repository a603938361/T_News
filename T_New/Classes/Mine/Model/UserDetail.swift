//
//  UserDetail.swift
//  T_New
//
//  Created by C.z on 2020/5/26.
//  Copyright © 2020 C.z. All rights reserved.
//

import Foundation
import HandyJSON

struct UserDetail: HandyJSON{
    
    var screen_name: String = ""
    var name: String = ""
    
    var big_avatar_url: String = "" // 头像
    var avatar_url: String = ""
    
    var status: Int = 0
    
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    
    var current_user_id: Int = 0
    
    var media_id: Int = 0               // 1554769814257666
    var ugc_publish_media_id: Int = 0   // 1576963425007630
    var user_id: Int = 0                // 53271122458
    var creator_id: Int = 0             // 53271122458
    
    var description: String = "" // 考研规划“神嘴”张雪峰老师。

//    screeenWidth - (15 + 15 + 40 + 5)
//    var descriptionHeight: CGFloat { return Calculate.textHeight(text: description, fontSize: 13, width: screenWidth - 30.0) }
    
    var apply_auth_url: String = "" // sslocal://apply_user_auth_info
    
    var bottom_tab: [BottomTab] = [BottomTab]()
    var top_tab: [TopTab] = [TopTab]()
    
    var bg_img_url: String = ""
    
    var verified_content: String = "无"
    var user_verified: Bool = false
    
    var verified_agency: String = "" // 头条认证
    
    var is_blocking: Bool = false
    var is_blocked: Bool = false
    
    var gender: Int = 0
    
    var share_url: String = ""
    
    var followers_count: Int = 0// 粉丝 470837
    var followersCount: String { return String(followers_count) }
    
    var followings_count: Int = 0 // 关注 3
    var followingsCount: String { return String(followings_count) }
    
    var media_type: Int = 0
    
    var area: String = ""
    
    var user_auth_info = UserAuthInfo()
}

struct TopTab: HandyJSON {
    var native_index_url: String = ""
    var url: String = ""
    var show_name: String = ""
    var is_default: Bool = false
    var type: DongTaiType = .dongtai
}

struct BottomTab {
    
}

enum DongTaiType: String, HandyJSONEnum {
    case dongtai = "dongtai"                            // 动态
    case article = "all"                                // 文章
    case video = "video"                                // 视频
    case wenda = "wenda"                                // 问答
    case iesVideo = "ies_video"                         // 小视频
}
