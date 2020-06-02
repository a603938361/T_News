//
//  File.swift
//  T_New
//
//  Created by C.z on 2020/5/7.
//  Copyright © 2020 C.z. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolPro {
    //--------------- home -------------
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ sections:[HomeNewsTitle])->())
    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,  _ dongtais:[UDongtai])->())

    //--------------- mine -------------

    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MyCellModel]])->())
    static func loadMyConcern(completionHandler: @escaping (_ sections:[MyConcern])->())
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail:UserDetail)->())
    
    //--------------- 火山 -------------
    static func loadHuoShanMovie(completionHandler: @escaping(_ section:[HuoShanModel])->())
    
}

extension NetworkToolPro{
    
}

struct NetworkTool: NetworkToolPro{
    static func loadHuoShanMovie(completionHandler:@escaping ([HuoShanModel]) -> ()) {
        let url = "https://api3-normal-c-lq.snssdk.com/api/news/feed/v64/?version_code=7.7.3&tma_jssdk_version=1.64.0.8&app_name=news_article&vid=8C9921F6-845F-4FF0-A70E-9C9B70B10E0C&device_id=68759605563&channel=App%20Store&resolution=1242*2208&aid=13&ab_feature=794527,1662483,1538698,1650563&ab_version=1419036,668775,1529253,1190525,1157750,1549051,1419598,1672696,1629529,1469498,1484966,1576656,1593455,1742596,668779,662099,668774,1742771,660830,662176,1738571&ab_group=794527,1662483,1538698,1650563&openudid=ecfe994098987b5ef2ff5777dd2a67e70a3a54a9&pos=5pe9vb/88Pzt3vTp5L+9p72/v7GXvb2//vTp5L+9p72/v7GXvb2/8fLz+vTp6Pn4v72nvayvrLOpqaqpr66qqq6lqqyorrGXvb2/8fzp9Ono+fi/vae9rqyzrKWlqqukr6ikpKWvq66ksZe9vb/88Pzt0fzp9Ono+fi/vae9rqyzrKWlqqukr6ikpKWvq66ksZe9vb/88Pzt0fLz+vTp6Pn4v72nvayvrLOpqaqpr66qqq6lqqyorrGXvb2/8fL+/PHC8fzp+O7pwu3y7r+9p73ml729vb2//vLy7/n08/zp+Mv88ej47r+9p73ml729vb29vb/x8vP69Ono+fi/vae9rK+ss6mpqqmvrqqqrqWqrKiusZe9vb29vb2/8fzp9Ono+fi/vae9rqyzrKWlqqukr6ikpKWvq66kl729vb3gsZe9vb29v+n08Pju6fzw7b+9p72sqKSsraWlr62ps6+lrK+tqqyXvb3gl+A=&cdid=955B0261-0EDA-405C-A53B-2A7004587C87&update_version_code=77321&idfv=8C9921F6-845F-4FF0-A70E-9C9B70B10E0C&ac=WIFI&os_version=13.3.1&ssmix=a&device_platform=iphone&iid=3984273896908784&ab_client=a1,f2,f7,e1&device_type=iPhone%206S%20Plus&idfa=0C913A9E-9701-4C5D-AC8C-FFA439AD8001&detail=1&category=video&last_refresh_sub_entrance_interval=5&list_entrance=main_tab&tt_from=pull&count=20&loc_mode=1&LBS_status=authroize&client_extra_params=%7B%22playparam%22%3A%22codec_type%3A1%22%7D&cp=52E1D8641146Dq1&min_behot_time=1591088229&image=1&strict=0&language=zh-Hans-CN&refer=1&ad_ui_style=%7B%22van_package%22%3A130000033%2C%22is_crowd_generalization_style%22%3Atrue%7D"
        
        AF.request(url).responseJSON { (res) in
            switch res.result{
            case .success(let data):
                let jsonData = JSON(data)
                guard jsonData["message"] == "success" else {return}
                guard let datas = jsonData["data"].array else {return}
                completionHandler(datas.compactMap {HuoShanModel.deserialize(from: $0["content"].string)})
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,_ dongtais: [UDongtai]) -> ()){
        
        let url = BASE_URL + "/dongtai/list/v15/?"
        let params = ["user_id": userId,
                      "max_cursor": maxCursor,
                      "device_id": device_id,
                      "iid": iid]
        AF.request(url, parameters: params).responseJSON { (res) in

            switch res.result{
            case .success(let data):
                let json = JSON(data)
                print(json)

                guard json["message"] == "success" else {return}
                if let da = json["data"].dictionary {
                    if let arr = da["data"]?.arrayObject{
                        var detailArr = [UDongtai]()
                        for item in arr {
                            
                            let model = UDongtai.deserialize(from: item as? Dictionary)
                            detailArr.append(model!)
                        }
                        completionHandler(0, detailArr)
                    }
                    
//                    completionHandler(0, )
                    
                    /**
                     
                     if let data = json["data"].arrayObject {
                         var concernArr = [MyConcern]()
                         
                         for item in data {
                             let model = MyConcern.deserialize(from: item as? Dictionary)
                             concernArr.append(model!)
                         }
                         completionHandler(concernArr)
                     }
                     
                     */
                    
                    
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    
    /// 获取用户详情数据
    /// - parameter userId: 用户id
    /// - parameter completionHandler: 返回用户详情数据
    /// - parameter userDetail:  用户详情数据
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ userDetail:UserDetail)->()){
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        AF.request(url, parameters: params).responseJSON { (res) in
            switch res.result {
            case .success(let data):
                let json = JSON(data)
                guard json["message"] == "success" else {return}
                completionHandler(UserDetail.deserialize(from: json["data"].dictionaryObject)!)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    static func loadHomeNewsTitleData(completionHandler: @escaping ([HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let par = ["device_id":device_id, "iid": iid]
        AF.request(url, parameters: par).responseJSON { (res) in
            
            switch res.result{
            case.success(let re):
                print(re)
                break
            case .failure(let er):
                print(er)
                break
            }
        }
    }
    
    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MyCellModel]])->()){
        let url = BASE_URL + "/user/tab/tabs/?"
        let par = ["device_id":device_id]
        
        AF.request(url, parameters: par).responseJSON { (response) in
            
            //https://is.snssdk.com/user/tab/tabs/?&device_id=6096495334
            switch response.result{
                case let .success(res):
                    let json = JSON(res)
                    
                    if let data = json["data"].dictionary{
                        if let dataArr = data["sections"]?.array{
                                                
                            var sectionArr = [AnyObject]()
                            
                            for item in dataArr {
                                
                                var tempDataArr = [MyCellModel]()
                                for row in item.arrayObject ?? [] {
                                    let cellModel = MyCellModel.deserialize(from: row as? Dictionary)
                                    tempDataArr.append(cellModel!)
                                }
                                sectionArr.append(tempDataArr as AnyObject)
                            }
                            completionHandler(sectionArr as! [[MyCellModel]])
                        }
                    }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func loadMyConcern(completionHandler: @escaping (_ sections:[MyConcern])->()){
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        //https://is.snssdk.com/concern/v2/follow/my_follow/?&device_id=6096495334
        AF.request(url, parameters: params).responseJSON { (response) in
            
            switch response.result{
                case let .success(res):
                    let json = JSON(res)
                    
                    if let data = json["data"].arrayObject {
                        var concernArr = [MyConcern]()
                        
                        for item in data {
                            let model = MyConcern.deserialize(from: item as? Dictionary)
                            concernArr.append(model!)
                        }
                        completionHandler(concernArr)
                    }
            case let .failure(error):
                print(error)
            }
        }
    }
}
