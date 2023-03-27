//
//  GameTableViewCell.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import UIKit

protocol GameTableViewCellDelegate: NSObjectProtocol {
    func athleteDidSelectIn(gameCell: GameTableViewCell, at indexPath: IndexPath)
}

/// A table view cell to display information about a game including its title, year, and a list of athletes.
class GameTableViewCell: UITableViewCell {

    /// Constants used within the class.
    private enum Constant {

        static let athleteCellIdentifier = "Athlete"
    }

    /// The label that displays the game's title and year.
    @IBOutlet private weak var labeTitle: UILabel!

    /// The collection view that displays the game's athletes.
    @IBOutlet private weak var athletesCollectionView: UICollectionView!

    /// The view model of the game to be displayed in the cell.
    private(set) var gameViewModel: Game.ViewModel!
    
    weak var delegate: GameTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configures the cell with the given view model of a game.
    ///
    /// - Parameter gameViewModel: The view model of a game to be displayed in the cell.
    func configure(for gameViewModel: Game.ViewModel) {
        self.gameViewModel = gameViewModel

        labeTitle.text = gameViewModel.title + " \(gameViewModel.year)"
        athletesCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GameTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        gameViewModel.athletes.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let athleteCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.athleteCellIdentifier,
            for: indexPath
        ) as? AthleteCollectionCell else {
            fatalError("Cannot dequeue the cell")
        }

        athleteCell.configure(for: gameViewModel.athletes[indexPath.item])
        return athleteCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        delegate?.athleteDidSelectIn(gameCell: self, at: indexPath)
    }
}

