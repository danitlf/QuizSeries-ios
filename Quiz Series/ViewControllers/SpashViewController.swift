//
//  SpashViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 30/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class SpashViewController: UIViewController {
    
    let serieApi = SeriesAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //if already have a user saved go to list of series
        if User().getUserDefaults() == nil {
            self.serieApi.loadListOfSeries() {
                self.performSegue(withIdentifier: "ListSegueFromSplash" , sender: self.serieApi.allSeries)
            }
        }
        else {
            performSegue(withIdentifier: "EnterSegueFromSplash", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListSegueFromSplash" {
            if let listSeriesViewController = segue.destination as? ListSeriesViewController {
                listSeriesViewController.listSeries = sender as! [Serie]
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
