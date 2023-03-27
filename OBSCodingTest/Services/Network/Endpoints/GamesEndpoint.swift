//
//  GamesEndpoint.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import Foundation
import UIKit

/// An enumeration of endpoints for the Games API.
enum GamesEndpoint : Endpoint {

    // MARK: - Cases

    /// The endpoint for retrieving all games.
    case allGames

    /// The endpoint for retrieving all athletes.
    case allAtheles

    /// The endpoint for retrieving all athletes in a specific game.
    /// - Parameter gameId: The ID of the game to retrieve athletes for.
    case athleteInGame(String)

    /// The endpoint for retrieving the details of a specific athlete.
    /// - Parameter atheleteId: The ID of the athlete to retrieve details for.
    case atheleteDetail(String)

    /// The endpoint for retrieving the results of a specific athlete.
    /// - Parameter athleteId: The ID of the athlete to retrieve results for.
    case atheleteResults(String)

    // MARK: - Properties
    
    /// The path component of the endpoint URL.
    var path: String {
        switch self {
        case .allGames:
            return "games"
        case .athleteInGame(let gameId):
            return "games/\(gameId)/athletes"
        case .allAtheles:
            return "athletes"
        case .atheleteDetail(let atheleteId):
            return "athletes/\(atheleteId)"
        case .atheleteResults(let athleteId):
            return "athletes/\(athleteId)/results"
        }
    }

    /// The HTTP method used by the endpoint.
    var method: HTTPMethod {
        .get
    }

    /// The content type of the HTTP body used by the endpoint.
    var contentType: HTTPContentType {
        .form
    }

    /// The HTTP body parameters used by the endpoint.
    var body: HTTPParameters {
        let body = HTTPParameters()
        switch self {
        default:
            break
        }
        return body
    }
}
