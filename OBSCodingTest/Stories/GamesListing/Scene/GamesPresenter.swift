//
//  GamesPresenter.swift
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

protocol GamesPresentationLogic {

    func presentGames(response: Game.GameListing.Response)
    func presentGameAthletes(response: Game.GameAthletes.Response)
    func presentPrepareGames(response: Game.Prepare.Response)
}

class GamesPresenter: GamesPresentationLogic {

    // MARK: - Properties

    /// The view controller that the presenter is communicating with.
    weak var viewController: GamesDisplayLogic?

    // MARK: - GamesPresentationLogic

    /**
     Presents the list of games to the view controller.
     
     - Parameters:
        - response: The response containing the list of games.
     */
    func presentGames(response: Game.GameListing.Response) {
        // Convert the list of games from the response to a list of view models.
        var games = response.games.compactMap {
            Game.ViewModel(
                id: $0.gameId ?? 0,
                title: $0.city ?? "",
                year: $0.year ?? -1,
                athletes: []
            )
        }

        // Sort the list of games by year.
        games = games.sorted(by: { $0.year < $1.year })
        
        // Update the view controller on the main thread with the list of view models.
        DispatchQueue.main.async {
            self.viewController?.displayFetchedGames(
                viewModel: Game.GameListing.ViewModel(games: games)
            )
        }
    }

    /**
     Presents the list of athletes for each game to the view controller.

     - Parameters:
        - response: The response containing the list of games and their athletes.
     */
    func presentGameAthletes(response: Game.GameAthletes.Response) {
        // Convert the list of games and their athletes from the response to a list of view models.
        let games = response.gamesAthletes.compactMap { gameAthletes in
            let gameModel = Game.ViewModel(
                id: Int(gameAthletes.key)!,
                title: "",
                year: -1,
                athletes: gameAthletes.value
            )
            return gameModel
        }

        // Update the view controller on the main thread with the list of view models.
        DispatchQueue.main.async {
            self.viewController?.displayGamesAthletes(
                viewModel: Game.GameAthletes.ViewModel(games: games)
            )
        }
    }

    /**
     Presents the list of games that can be played to the view controller.

     - Parameters:
        - response: The response containing the list of games.
     */
    func presentPrepareGames(response: Game.Prepare.Response) {
        // Update the view controller with the list of games on the main thread.
        DispatchQueue.main.async {
            self.viewController?.displayPrepareGames(
                viewModel: Game.Prepare.ViewModel(games: response.games)
            )
        }
    }
}
