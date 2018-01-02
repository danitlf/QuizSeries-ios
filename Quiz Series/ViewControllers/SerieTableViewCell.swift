//
//  SerieTableViewCell.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 01/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import UIKit
import Kingfisher

class SerieTableViewCell: UITableViewCell {

    @IBOutlet weak var serieName: UILabel!
    @IBOutlet weak var serieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with serie: Serie) {
        serieName.text = serie.label
        let url = URL(string: serie.url_icon)
        serieImage.kf.setImage(with: url)
        self.backgroundColor = hexStringToUIColor(hex: serie.cor)
    }
    

}
