//
//  GamesAPIStore.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 26/03/2023.
//

import Foundation

class GamesAPIStore: NSObject {

    private var group: DispatchGroup!

    /// Fetches all games from the API.
    /// - Returns: An array of `AllGamesResponse` objects if successful, otherwise an empty array.
    func fetchGames() async -> [AllGamesResponse] {
        let endpoint = GamesEndpoint.allGames

        do {
            let result = try await NetworkLayer.fetch(endpoint, with: [AllGamesResponse].self)
            let games: [AllGamesResponse]
            switch result {
            case .failure(_):
                games = []
            case .success(let models):
                games = models
            }
            return games
        } catch {
            return []
        }
    }

    /// Fetches all athletes for the given game IDs.
    /// - Parameters:
    ///   - gameIDS: An array of game IDs for which athletes are to be fetched.
    ///   - completion: A closure to be called with the fetched athletes.
    func fetchGamesAthlete(gameIDS: [String], completion: @escaping ([String: [AthleteResponse]]) -> Void) async {
        group = DispatchGroup()
        var gamesAthletesMap = [String: [AthleteResponse]]()
        for gameId in gameIDS {
            group.enter()

            let athletes = await fetchAthletesForGame(withID: gameId)
            gamesAthletesMap[gameId] = athletes
        }
        group.notify(queue: .main) {
            completion(gamesAthletesMap)
        }
    }

    // MARK: - Private

    /// Fetches all athletes for the given game ID.
    /// - Parameter id: The game ID for which athletes are to be fetched.
    /// - Returns: An array of `AthleteResponse` objects if successful, otherwise an empty array.
    private func fetchAthletesForGame(withID id: String) async -> [AthleteResponse] {
        let endpoint = GamesEndpoint.athleteInGame(id)
        do {
            let athleteResponse = try await NetworkLayer.fetch(endpoint, with: [AthleteResponse].self)
            let gameAthletes: [AthleteResponse]
            switch athleteResponse {
            case .failure(_):
                gameAthletes = []
            case .success(let athletes):
                gameAthletes = athletes
            }
            group.leave()
            return gameAthletes
        } catch {
            return []
        }
    }
}
