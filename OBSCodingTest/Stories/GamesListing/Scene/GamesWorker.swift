//
//  GamesWorker.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 26/03/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Completion handler for fetching games athletes.
typealias FetchGamesAthletesCompletion = ([String: [AthleteResponse]]) -> Void

/// The worker responsible for fetching games data from the API.
class GamesWorker {
    // MARK: - Properties

    /// The API store to use for fetching games data.
    private let apiStore: GamesAPIStore

    // MARK: - Initializer

    /// Initializes a new instance of `GamesWorker`.
    /// - Parameter apiStore: The API store to use for fetching games data.
    init(apiStore: GamesAPIStore) {
        self.apiStore = apiStore
    }

    // MARK: - Async Functions

    /// Fetches all games.
    /// - Returns: An array of all games fetched.
    func fetchGames() async -> [AllGamesResponse] {
        await apiStore.fetchGames()
    }

    /// Fetches the athletes for the specified games.
    /// - Parameters:
    /// - gameIDS: The IDs of the games to fetch athletes for.
    /// - completion: The completion handler to call when the athletes are fetched.
    func fetchGamesAthletes(gameIDS: [String],
                            completion: @escaping FetchGamesAthletesCompletion) async {
        await apiStore.fetchGamesAthlete(
            gameIDS: gameIDS
        ) { athletes in
            completion(athletes)
        }
    }
}
