//
//  LevelTableViewCell.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 08/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {

    @IBOutlet weak var boxLevel: LevelTableViewCell!
    @IBAction func playLevel(_ sender: Any) {
        print("jogar o level \(levelNumber!)")
    }
    @IBOutlet weak var levelLabel: UILabel!
    var levelNumber: Int?
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
        self.levelNumber = level.numberFase
        self.boxLevel.layer.cornerRadius = 10
    }

}
