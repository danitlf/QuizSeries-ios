//
//  FirebaseAPI.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 07/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class FirebaseAPI {
    
    let id = Auth.auth().currentUser?.uid
    let ref = Database.database().reference(withPath: "users")
    var coins: Int = 200
    
    func updateCoins(coins: Int){
        self.ref.child(self.id!).setValue(["coins": coins])
    }
    
    func observeCoins(completed: @escaping DownloadComplete){
        print(id!)
        ref.child(id!).child("coins").observe(.value) { (snapshot) in
            if let coinsFirebase = snapshot.value as? Int {
                print(coinsFirebase)
                self.coins = coinsFirebase
                completed()
            }
        }
    }
    
    func saveSerie(serie: SerieFirebase, idOfSerie: Int){
        ref.child(id!).child("seriesOfUser").child("\(idOfSerie)").setValue(serie.toDicrionary())
    }
    
    func saveLevelOfSerie(level: LevelFirebase, idOfSerie: Int, numberOfLevel: Int){
         ref.child(id!).child("seriesOfUser").child("\(idOfSerie)").child("fasesOfSerie").child("\(numberOfLevel)").setValue(level.toDicrionary())
    }
    
    func getLevelsOf(idOfSerie: Int, completed: @escaping ([String: LevelFirebase]) -> ()){
        var listOflevels = [String: LevelFirebase]()
        ref.child(id!).child("seriesOfUser").child("\(idOfSerie)").child("fasesOfSerie").observe(.value) { (snapshot) in
            if let rows = snapshot.value as? [String: Any] {
                for row in rows {
                    let jsonOfLevel: JSON = JSON(row.value)
                    let serie = try! JSONDecoder().decode(LevelFirebase.self, from: jsonOfLevel.rawData())
                    listOflevels[row.key] = serie
                }
            }
            completed(listOflevels)
        }
    }
    
    func getScoreOf(idOfSerie: Int, completed: @escaping (Int) -> ()){
        ref.child(id!).child("seriesOfUser").child("\(idOfSerie)").child("scoreTotal").observe(.value) { (snapshot) in
            if let score = snapshot.value as? Int{
                print(score)
                completed(score)
            }
            else {
                completed(0)
            }
        }
    }
    
    func initialCreateFIrebaseUser(){
        ref.child(id!).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                //User is signing IN
                print("user already exists")
            }
            else {
                //User is signing UP
                self.ref.child(self.id!).setValue(["coins":200])
            }
        })
    }
}
