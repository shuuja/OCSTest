//
//  AthleteResponse.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

struct AthleteResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case athleteId = "athlete_id"
        case height
        case dateOfBirth
        case name
        case photoId = "photo_id"
        case weight
        case surname
        case bio
    }

    var athleteId: String?
    var height: Int?
    var dateOfBirth: String?
    var name: String?
    var photoId: Int?
    var weight: Int?
    var surname: String?
    var bio: String?
}
