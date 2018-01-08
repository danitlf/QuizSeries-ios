//
//  LevelScore.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 05/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import Foundation

class LevelScore {
    var levelsScore = [Int:Int]()
    var numOfLevels: Int = 0
    
    let baseNumOfQuestionsRightForLevel = 10
    
    init(numOfLevels: Int){
        self.numOfLevels = numOfLevels
        generatingLevelsScore()
    }
    
    func generatingLevelsScore(){
        var pointsForNext = 0
        levelsScore[1] = 0
        for i in 1...(self.numOfLevels+1) {
            pointsForNext = pointsForNext + (baseNumOfQuestionsRightForLevel+(i/3))*10
            levelsScore[i+1] = pointsForNext
        }
    }
    
    func getScore(of level: Int) -> Int{
        return levelsScore[level]!
    }
    
    func generatingLevels() -> [Level] {
        var levels = [Level]()
        if self.numOfLevels != 0{
            for i in 1...self.numOfLevels{
                if let score = self.levelsScore[i] {
                    let l = Level(numberFase: i, score: score)
                    levels.append(l)
                }
            }
        }
        return levels
    }
}
