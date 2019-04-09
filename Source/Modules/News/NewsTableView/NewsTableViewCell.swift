//
//  NewsTableViewCell.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setup(_ item: RssItemDto) {
        newsTitleLabel.text = item.title
        if let thumbnailUrl = item.enclosure?.url {
            thumbnail.download(from: thumbnailUrl)
        }
        if let date = item.pubDate {
            dateLabel.text = String.dateFrom(MagicValues.fullDateFormat, date: date)
        }
    }

}
