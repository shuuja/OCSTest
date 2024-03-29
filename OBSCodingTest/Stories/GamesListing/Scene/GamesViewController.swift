//
//  GamesViewController.swift
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

/// The display logic for the Games module.
protocol GamesDisplayLogic: NSObjectProtocol {
    func displayFetchedGames(viewModel: Game.GameListing.ViewModel)
    func displayGamesAthletes(viewModel: Game.GameAthletes.ViewModel)
    func displayPrepareGames(viewModel: Game.Prepare.ViewModel)
}

/// The view controller for the Games module.
class GamesViewController: UIViewController, GamesDisplayLogic {

    // MARK: - Private Constants

    private enum Constant {
        static let numberOfRows = 1
        static let footerHeight = CGFloat(15.0)
        static let gameCellIdentifer = "Game"
        static let athleteDetailSegueIdentifier = "AthleteDetail"
    }

    // MARK: - Properties

    @IBOutlet private weak var gamesTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private var games = [Game.ViewModel]()
    var interactor: GamesBusinessLogic?
    var router: (NSObjectProtocol & GamesRoutingLogic & GamesDataPassing)?

    // MARK: - Object Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = GamesInteractor()
        let presenter = GamesPresenter()
        let router = GamesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Task { await fetchGames() }
    }

    // MARK: - Display

    func displayFetchedGames(viewModel: Game.GameListing.ViewModel) {
        games = viewModel.games
        Task { await fetchGamesAthletes() }
    }

    func displayGamesAthletes(viewModel: Game.GameAthletes.ViewModel) {
        interactor?.prepareGames(games: games, gamesWithAthletes: viewModel.games)
    }

    func displayPrepareGames(viewModel: Game.Prepare.ViewModel) {
        activityIndicator.isHidden = true
        games = viewModel.games
        gamesTableView.reloadData()
    }

    // MARK: - Private Methods

    private func fetchGames() async {
        await interactor?.fetchGames()
    }

    private func fetchGamesAthletes() async {
        await interactor?.fetchGamesAthletes(
            request: Game.GameAthletes.Request(
                gameIDS: games.compactMap { "\($0.id)" }
            )
        )
    }

}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension GamesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        games.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        Constant.numberOfRows
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let gameCell = tableView.dequeueReusableCell(
            withIdentifier: Constant.gameCellIdentifer, for: indexPath
        ) as? GameTableViewCell else {
            fatalError(
                "Unable to dequeue cell with identifier: \(Constant.gameCellIdentifer)"
            )
        }

        gameCell.configure(for: games[indexPath.section])
        gameCell.delegate = self
        return gameCell
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        Constant.footerHeight
    }
}

// MARK: - GameTableViewCellDelegate

extension GamesViewController: GameTableViewCellDelegate {

    // Handles the event when a user taps on an athlete cell within a game cell in the table view
    func athleteDidSelectIn(
        gameCell: GameTableViewCell,
        at indexPath: IndexPath
    ) {

        // Get the index path of the game cell that was tapped
        guard let gameIndexPath = gamesTableView.indexPath(for: gameCell) else {
            return
        }

        // Set the selected athlete in the interactor's data store
        var destinationDataStore = interactor as? GamesDataStore
        destinationDataStore?.selectedAthlete = games[gameIndexPath.section].athletes[indexPath.item]

        // Perform the segue to display the athlete detail view controller
        performSegue(
            withIdentifier: Constant.athleteDetailSegueIdentifier, sender: nil
        )
    }
}
