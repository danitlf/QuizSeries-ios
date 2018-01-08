//
//  SeriesOfUser.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 07/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import Foundation

struct SerieFirebase: Codable {
    var label: String
    var scoreTotal: Int
}

struct LevelFirebase: Codable {
    var score: Int
    var played: Bool
}

