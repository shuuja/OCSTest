//
//  AthleteBioCell.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 27/03/2023.
//

import UIKit

/// A table view cell for displaying an athlete's biography.
class AthleteBioCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var labelBio: UILabel!

    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Methods

    /**
     Configures the cell with an athlete's biography.

     - Parameter athlete: The athlete whose biography will be displayed in the cell.
     */
    func configure(_ athlete: AthleteResponse) {
        labelBio.text = athlete.bio
    }
}
