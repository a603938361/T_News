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
    static func loadMyConcern()
    
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
    
    static func loadMyConcern() {
        
    }
}
