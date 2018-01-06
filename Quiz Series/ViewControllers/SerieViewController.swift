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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableLevels.delegate = self
        tableLevels.dataSource = self
        tableLevels.separatorStyle = .none
        
        let lv = Level(numberFase: 1, score: 0)
        levels.append(lv)
        
        
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCellBlock", for: indexPath) as! LevelBlockTableViewCell
        cell.prepare(with: levels[0])
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
