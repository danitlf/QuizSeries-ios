//
//  ListSeriesViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 31/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase

class ListSeriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var tableSeries: UITableView!
    @IBOutlet weak var userCoinsLabel: UILabel!
    var listSeries: [Serie] = [Serie]()
    let serieApi = SeriesAPI()
    var selectedSerie: Serie?
    var imageSerieSelected: UIImage?
    let fapiFirebaseAPI = FirebaseAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableSeries.delegate = self
        tableSeries.dataSource = self
        tableSeries.separatorStyle = .none
        
        self.imagePerfil.layer.cornerRadius = self.imagePerfil.frame.width/2
        self.imagePerfil.clipsToBounds = true
        
        UINavigationBar.appearance().barTintColor = hexStringToUIColor(hex: "#ffffff")
        UINavigationBar.appearance().isTranslucent = true
        
        //if dont come of splash screen direct
        if self.listSeries.count < 1 {
            self.serieApi.loadListOfSeries() {
                self.listSeries =  self.serieApi.allSeries
                self.tableSeries.reloadData()
            }
        }
        
        //push image from facebook
        getFBUserData()
        
        fapiFirebaseAPI.observeCoins {
            self.userCoinsLabel.text = "\(self.fapiFirebaseAPI.coins)"
        }
        
        //fapiFirebaseAPI.saveLevelOfSerie(level: LevelFirebase(score: 0, played: false) , idOfSerie: 1, numberOfLevel: 4)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getFBUserData()
    {
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me",
                              parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender"]).start(
                                completionHandler: { (connection, result, error) -> Void in
                                    if (error == nil){
                                        let data = result as! [String : AnyObject]
                                        let FBid = data["id"] as? String
                                        let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                                        self.imagePerfil.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)

                                    }})
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieCell", for: indexPath) as! SerieTableViewCell
        cell.prepare(with: listSeries[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSerie = self.listSeries[indexPath.row]
        let currentCell = tableView.cellForRow(at: indexPath) as! SerieTableViewCell!
        self.imageSerieSelected = currentCell?.serieImage.image
        self.performSegue(withIdentifier: "SegueToSerie", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToSerie" {
            if let seriesViewController = segue.destination as? SerieViewController {
                seriesViewController.serie = self.selectedSerie
                seriesViewController.logoSerie = self.imageSerieSelected
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
