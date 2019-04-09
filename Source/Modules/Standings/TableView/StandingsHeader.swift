//
//  StandingsHeader.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 09/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import UIKit

class StandingsHeader: DesignableView {

    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var goalDifferenceLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rlgLabel: UILabel!

    override var nib: String? {
        return "StandingsHeader"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTranslation()
    }

}

final class StandingsHeaderDisplayData {
    let clubName = "Club".localized()
    let played = "P".localized()
    let won = "W".localized()
    let draw = "D".localized()
    let lost = "L".localized()
    let goadDifference = "GD".localized()
    let points = "Pts".localized()
    let relegation = "Rlg".localized()
}

fileprivate extension StandingsHeader {

    func setupTranslation() {
        let displayData = StandingsHeaderDisplayData()
        clubNameLabel.text = displayData.clubName
        playedLabel.text = displayData.played
        wonLabel.text = displayData.won
        drawLabel.text = displayData.draw
        lostLabel.text = displayData.lost
        goalDifferenceLabel.text = displayData.goadDifference
        pointsLabel.text = displayData.points
        rlgLabel.text = displayData.relegation
    }

}
