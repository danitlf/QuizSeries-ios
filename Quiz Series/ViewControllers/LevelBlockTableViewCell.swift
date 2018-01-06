//
//  LevelBlockTableViewCell.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 06/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class LevelBlockTableViewCell: UITableViewCell {

    @IBOutlet weak var pontosLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var boxLevel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with level: Level) {
        self.levelLabel.text = "Lv \(level.numberFase)"
        self.pontosLabel.text = "\(level.score) pts"
        self.boxLevel.layer.cornerRadius = 10
    }

}
