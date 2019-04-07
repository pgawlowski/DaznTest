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
    let name: String?
    let value: String?
}

struct SeasonDto: Codable {
    let round: RoundDto?
}

struct RoundDto: Codable {
    let group: [GroupDto]?
    let resultstable: ResultsDto?
}

struct GroupDto: Codable {
    let match: [MatchDto]?
}

struct MatchDto: Codable {
    let team_A_name: String?
    let team_B_name: String?
    let fs_A: Int?
    let fs_B: Int?
}

struct ResultsDto: Codable {
    let ranking: [RankingDto]?
}

struct RankingDto: Codable {
    let rank: Int?
    let last_rank: Int?
    let zone_start: String?
//    let "_team_id": "676",
//    let "_club_name": "Manchester City",
//    let "_countrycode": "ENG",
//    let "_area_id": "68",
    let matches_total: Int?
    let matches_won: Int?
    let matches_draw: Int?
    let matches_lost: Int?
    let goals_pro: Int?
    let goals_against: Int?
    let points: Int?
}
