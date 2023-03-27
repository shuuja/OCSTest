//
//  AthleteResultResponse.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

struct AthleteResultResponse: Codable {

    private enum Constant {

        static let goldPoints = 5
        static let silverPoints = 3
        static let bronzePoints = 1
    }

    var year: Int?
    var silver: Int?
    var gold: Int?
    var bronze: Int?
    var city: String?
}

extension AthleteResultResponse {

    var globalScore: Int {
        let goldPoints = (gold ?? 0) * Constant.goldPoints
        let silverPoints = (silver ?? 0) * Constant.silverPoints
        let bronzePoints = (bronze ?? 0) * Constant.bronzePoints
        return (goldPoints + silverPoints + bronzePoints)
    }
}
