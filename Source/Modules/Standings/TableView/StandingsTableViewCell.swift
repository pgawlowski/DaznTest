//
//  StandingsTableViewCell.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 09/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import FontAwesomeKit_Swift
import UIKit

class StandingsTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var goalDifferenceLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rlgLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(_ item: RankingDto) {
        let rank = item.rank ?? 0
        let bgColor = (rank % 2 == 1) ? UIColor.lightGray.withAlphaComponent(0.5) : UIColor.white
        backgroundColor = bgColor

        positionLabel.text = String(format: "%02d", item.rank ?? 0)
        clubNameLabel.text = item.club_name
        playedLabel.text = item.matches_total?.string ?? "0"
        wonLabel.text = item.matches_draw?.string ?? "0"
        drawLabel.text = item.matches_draw?.string ?? "0"
        lostLabel.text = item.matches_lost?.string ?? "0"
        goalDifferenceLabel.text = item.goalDifference?.string ?? "0"
        pointsLabel.text = item.points?.string ?? "0"

        rlgLabel.font = UIFont.fa?.fontSize(20)
        switch item.relegation {
        case .Up:
            rlgLabel.text = String.fa.fontAwesome(.arrowUp)
        case .Down:
            rlgLabel.text = String.fa.fontAwesome(.arrowDown)
        case .NoChange:
            rlgLabel.text = "-"
        }
    }
    
}
