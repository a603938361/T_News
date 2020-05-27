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
}

extension NetworkToolPro{
    
}

struct NetworkTool: NetworkToolPro{
    
    
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
