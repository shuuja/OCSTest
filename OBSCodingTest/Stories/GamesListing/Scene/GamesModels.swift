//
//  GamesModels.swift
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

enum Game {
    
    struct ViewModel {
        let id: Int
        let title: String
        let year: Int
        var athletes: [AthleteResponse]
    }

    // MARK: - GameListing

    enum GameListing {

        struct Response {
            let games: [AllGamesResponse]
        }

        struct ViewModel {
            let games: [Game.ViewModel]
        }
    }

    // MARK: - Prepare

    enum Prepare {
        struct Response {
            let games: [Game.ViewModel]
        }

        struct ViewModel {
            let games: [Game.ViewModel]
        }
    }

    // MARK: - GameAthletes

    enum GameAthletes {

        struct Request {
            let gameIDS: [String]
        }

        struct Response {
            let gamesAthletes: [String: [AthleteResponse]]
        }

        struct ViewModel {
            let games: [Game.ViewModel]
        }
    }
}
