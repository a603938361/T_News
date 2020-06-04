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
    
    
    var abstract: String?
    var comment_count: Int = 0
    var comment_count_str: String { return (String(comment_count))}

    var article_url: String?
    var filter_words: [Filter_words]?
    var composition: Int64 = 0
    var composition_str: String { return String(composition) + "次播放"}

    var user_info = User_info()
    var large_image_list = [Large_image_list]()
    
}

struct Large_image_list: HandyJSON {
    var url: String?

}

struct User_info: HandyJSON {
    var avatar_url: String?
    var description: String?
    var name: String?
}

struct Filter_words: HandyJSON  {
    var id: String?
    var is_selected: Bool?
    var name: String?
}

struct Data: HandyJSON {
    var content = ""
    var code = ""
}

struct Tips: HandyJSON  {
    
    var type = ""
    var display_duration = ""
    var display_info = ""
    var display_template = ""
    var open_url = ""
    var web_url = ""
    var download_url = ""
    var app_name = ""
}
