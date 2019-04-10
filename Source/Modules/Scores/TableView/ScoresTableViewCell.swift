//
//  ScoresTableViewCell.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var teamALabel: UILabel!
    @IBOutlet weak var teamBLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(_ match: MatchDto) {
        teamALabel.text = match.team_A_name
        teamBLabel.text = match.team_B_name
        scoreLabel.text = String(format: "%i - %i", match.fs_A ?? 0, match.fs_B ?? 0)
    }
}
