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
    var allSeries: [Serie] = []

    func loadListOfSeries(completed: @escaping DownloadComplete){
        Alamofire.request(apiUrl+"series/").responseJSON { (response) in
            let json: JSON = JSON(response.result.value as Any)
            if let series = json["series"].array {
                for s in series {
                    let serie = try! JSONDecoder().decode(Serie.self, from: s.rawData())
                    self.allSeries.append(serie)
                    
                }
            }
            completed()
        }
    }
    
    func getQuestionsOfLevel(levelNumber: Int, idSerie: Int, completed: @escaping ([Question])->()){
        var allQuestions = [Question]()
        Alamofire.request(apiUrl+"series/\(idSerie)/questions/\(levelNumber)").responseJSON { (response) in
            let json: JSON = JSON(response.result.value as Any)
            if let questions = json["questions"].array {
                for question in questions {
                    let questionObject = try! JSONDecoder().decode(Question.self, from: question.rawData())
                    allQuestions.append(questionObject)
                    
                }
            }
            completed(allQuestions)
        }
    }
    
}
