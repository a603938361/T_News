
//
//  MyCellModel.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import Foundation
import HandyJSON

struct MyCellModel: HandyJSON{
    var grey_text = ""
    var text = ""
    var url = ""
    var key = ""
    var tip_new = 0
}


struct MyConcern: HandyJSON {
    
    var name: String = ""
    var url: String = ""
    var total_count: Int = 0
    var description: String = ""
    var time: String = ""
    var type: String = ""
    var icon: String = ""
    var userid: Int = 0
    var is_verify: Bool = false
    var media_id: Int = 0
    var tips: Bool = false
    var id: Int = 0
    var user_auth_info = UserAuthInfo()
}

struct UserAuthInfo: HandyJSON {
    var auth_type: Int = 0
    var auth_info: String = ""
}
