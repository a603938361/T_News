//
//  HuoShanModel.swift
//  T_New
//
//  Created by C.z on 2020/6/2.
//  Copyright © 2020 C.z. All rights reserved.
//

import Foundation
import HandyJSON


struct HuoShanModel: HandyJSON {
    
    var tips = Tips()
    var total_number = 0
    var post_content_hint = ""
    var data = [Data]()
    
}

struct Data {
    var content = ""
    var code = ""
}

struct Tips {
    
    var type = ""
    var display_duration = ""
    var display_info = ""
    var display_template = ""
    var open_url = ""
    var web_url = ""
    var download_url = ""
    var app_name = ""
}
