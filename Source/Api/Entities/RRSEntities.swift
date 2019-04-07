//
//  RRSEntieties.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation

struct RssDto: Codable {
    let channel: ChannelDto?
}

struct ChannelDto: Codable {
    let title: String?
    let description: String?
    let language: String?
    let pubDate: Date?
    let link: URL?
    let item: [RssItemDto]?
}

struct RssItemDto: Codable {
    let guid: String?
    let title: String?
    let pubDate: Date?
    let description: String?
    let link: URL?
    let category: String?
    let enclosure: EnclosureDto?
}

struct EnclosureDto: Codable {
    let length: Int?
    let url: URL?
    let type: String?
}
