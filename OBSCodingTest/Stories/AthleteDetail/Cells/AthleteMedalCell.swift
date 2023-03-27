//
//  AthleteMedalCell.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 27/03/2023.
//

import UIKit

/// A table view cell for displaying an athlete's medals.
class AthleteMedalCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var viewMedals: AthleteMedalsView!
    @IBOutlet private weak var labelGameName: UILabel!

    // MARK: - Public Methods

    /**
     Configures the cell with an athlete's medals.

     - Parameter result: The athlete's result whose medals will be displayed in the cell.
     */
    func configure(_ result: AthleteResultResponse) {
        viewMedals.configure(result)
        labelGameName.text = result.city
    }
}

