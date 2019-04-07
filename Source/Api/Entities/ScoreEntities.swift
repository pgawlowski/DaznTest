//
//  ScoreEntities.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import Foundation

struct GsmrsDto : Codable {
    let method: MethodDto?
    let competition: CompetitionDto?
}

struct MethodDto: Codable {
    let parameter: [ParameterDto]?
}

struct CompetitionDto: Codable {
    let season: SeasonDto?
}

enum ParameterType: String, Codable {
    case date
}

struct ParameterDto: Codable {
    let _name: String?
    let _value: String?
}

struct SeasonDto: Codable {
    let round: RoundDto?
}

struct RoundDto: Codable {
    let group: [GroupDto]?
    let resultstable: ResultsDto?
}

struct GroupDto: Codable {
    let matchDto: [MatchDto]?
}

struct MatchDto: Codable {
    let _team_A_Name: String?
    let _team_B_Name: String?
    let _fs_A: Int?
    let _fs_B: Int?
}

struct ResultsDto: Codable {
    let ranking: [RankingDto]?
}

struct RankingDto: Codable {
    let _rank: Int?
    let _last_rank: Int?
    let _zone_start: String?
//    let "_team_id": "676",
//    let "_club_name": "Manchester City",
//    let "_countrycode": "ENG",
//    let "_area_id": "68",
    let _matches_total: Int?
    let _matches_won: Int?
    let _matches_draw: Int?
    let _matches_lost: Int?
    let _goals_pro: Int?
    let _goals_against: Int?
    let _points: Int?
}
