//
//  LevelPlayedTableViewCell.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 08/01/18.
//  Copyright © 2018 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class LevelPlayedTableViewCell: UITableViewCell {

    @IBAction func playAgain(_ sender: Any) {
        print("jogar novamente")
    }
    @IBOutlet weak var pontosLabel: UILabel!
    @IBOutlet weak var boxLevel: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with level: Level, score: Int) {
        self.levelLabel.text = "Lv \(level.numberFase)"
        self.pontosLabel.text = "Score: \(score)pts"
        self.boxLevel.layer.cornerRadius = 10
    }

}
