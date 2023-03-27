//
//  AllGamesResponse.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

struct AllGamesResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case city
        case year
        case gameId = "game_id"
    }
    
    var city: String?
    var year: Int?
    var gameId: Int?
}
