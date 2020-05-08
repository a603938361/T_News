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
    //--------------- mine -------------
    
    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MyCellModel]])->())
    static func loadMyConcern(completionHandler: @escaping (_ sections:[MyConcern])->())
    
}

extension NetworkToolPro{
    
}

struct NetworkTool: NetworkToolPro{
    
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
