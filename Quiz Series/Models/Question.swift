//
//  Question.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 08/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import Foundation

struct Question: Codable {
    var label: String
    var a: String
    var b: String
    var c: String
    var d: String
    var right: String
}
