//
//  LevelScore.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 05/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import Foundation

class LevelScore {
    var levels = [Int:Int]()
    var numOfLevels: Int = 0
    let baseNumOfQuestionsRightForLevel = 10
    
    init(numOfLevels: Int){
        self.numOfLevels = numOfLevels
        generatingLevelsScore()
    }
    
    func generatingLevelsScore(){
        var pointsForNext = 0
        for i in 1...(self.numOfLevels+1) {
            pointsForNext = pointsForNext + (baseNumOfQuestionsRightForLevel+(i/3))*10
            levels[i+1] = pointsForNext
        }
        print(levels[10])
    }
}
