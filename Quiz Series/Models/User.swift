//
//  User.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 30/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import Foundation

class User {
    var userID: String?
    var userName: String?
    let defaults = UserDefaults.standard
    
    init(id: String? = nil, name: String? = nil) {
        self.userID = id
        self.userName = name
    }
    
    
    func saveUserOnDevice(){
        self.defaults.set(userID, forKey: USER_ID)
        self.defaults.set(userName, forKey: USER_NAME)
    }
    
    func getUserDefaults() -> String?{
       return defaults.string(forKey: USER_ID)
    }
    
    
    
}
