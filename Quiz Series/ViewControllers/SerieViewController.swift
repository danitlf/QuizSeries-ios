//
//  SerieViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 05/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class SerieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableLevels: UITableView!
    @IBOutlet weak var nameOfSerie: UILabel!
    @IBOutlet weak var viewTabBar: UIView!
    var serie: Serie?
    var logoSerie: UIImage?
    var levels = [Level]()
    var listOfLevels: [String: LevelFirebase]?
    let fapiFirebaseAPI = FirebaseAPI()
    var scoreTotal: Int?
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableLevels.delegate = self
        tableLevels.dataSource = self
        tableLevels.separatorStyle = .none
        
        if let numLevels = serie?.fase_count {
             let levelScore = LevelScore(numOfLevels: numLevels)
             self.levels = levelScore.generatingLevels()
        }
        
        fapiFirebaseAPI.getLevelsOf(idOfSerie: (self.serie?.id)!) { (listOfLevels) in
            self.listOfLevels = listOfLevels
            self.tableLevels.reloadData()
        }
        
        fapiFirebaseAPI.getScoreOf(idOfSerie: (self.serie?.id)!) { (score) in
            self.scoreTotal = score
            self.tableLevels.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavbar()
    }
    
    func configNavbar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: (self.serie?.cor)!)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        //image on navigationBar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.logoSerie
        self.navigationItem.titleView = imageView
        
        //configure TabBar
        self.nameOfSerie.text = self.serie?.label
        self.viewTabBar.backgroundColor = hexStringToUIColor(hex: (self.serie?.cor)!)
    }
    
    //tableviewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scoreTotal != nil && listOfLevels != nil {
            return levels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let score = scoreTotal, let listOfLevels = listOfLevels {
            if levels[indexPath.row].score > score {
                let cell = tableView.dequeueReusableCell(withIdentifier: "levelCellBlock", for: indexPath) as! LevelBlockTableViewCell
                cell.prepare(with: levels[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
            else {
                if let level = listOfLevels["\(levels[indexPath.row].numberFase)"] {
                    if level.played == true {
                        //level já jogado
                        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCellPlayed", for: indexPath) as! LevelPlayedTableViewCell
                        cell.prepare(with: levels[indexPath.row], score: level.score)
                        cell.selectionStyle = .none
                        return cell
                    }
                    else {
                        //level liberado pra jogar
                        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as! LevelTableViewCell
                        cell.prepare(with: levels[indexPath.row])
                        cell.selectionStyle = .none
                        cell.boxLevel.backgroundColor = hexStringToUIColor(hex: (self.serie?.cor)!)
                        return cell
                    }
                }
                else {
                     //level liberado pra jogar
                    let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as! LevelTableViewCell
                    cell.prepare(with: levels[indexPath.row])
                    cell.selectionStyle = .none
                    cell.boxLevel.backgroundColor = hexStringToUIColor(hex: (self.serie?.cor)!)
                    return cell
                }
            }
        }
        //level bloqueado
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCellBlock", for: indexPath) as! LevelBlockTableViewCell
        cell.prepare(with: levels[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    

   

}
