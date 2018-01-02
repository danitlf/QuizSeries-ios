//
//  SeriesAPI.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 30/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SeriesAPI {
    var createdUser: User = User()
    var allSeries: [Serie] = []
    
    func registerNickname(nickname: String, completed: @escaping DownloadComplete){
        let parameters: Parameters = ["name":nickname]
        let apiUserUrl = apiUrl+"users/"
        Alamofire.request(apiUserUrl,method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value)
                if let id = json["user_id"].string,  let name = json["name"].string{
                    self.createdUser = User(id: id, name: name)
                }
            }
            else {
                print("not succes")
            }
            completed()
        }
    }
    
//    "id": 8,
//    "label": "Breaking Bad",
//    "cor": "#57ba70",
//    "url_icon
    
    func loadListOfSeries(completed: @escaping DownloadComplete){
        Alamofire.request(apiUrl+"series/").responseJSON { (response) in
            let json: JSON = JSON(response.result.value)
            if let series = json["series"].array {
                for s in series {
                    let serie = try! JSONDecoder().decode(Serie.self, from: s.rawData())
                    self.allSeries.append(serie)
                    
                }
            }
            completed()
        }
    }
    
}
