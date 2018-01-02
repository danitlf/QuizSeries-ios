//
//  ListSeriesViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 31/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class ListSeriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableSeries: UITableView!
    var listSeries: [Serie] = []
    let serieApi = SeriesAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableSeries.delegate = self
        tableSeries.dataSource = self
        tableSeries.separatorStyle = .none
        
        self.serieApi.loadListOfSeries() {
            self.listSeries =  self.serieApi.allSeries
            self.tableSeries.reloadData()
        }
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieCell", for: indexPath) as! SerieTableViewCell
        cell.prepare(with: listSeries[indexPath.row])
        return cell
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
