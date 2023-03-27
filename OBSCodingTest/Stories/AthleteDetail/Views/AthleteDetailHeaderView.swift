//
//  AthleteDetailHeaderView.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 27/03/2023.
//

import UIKit
/**
The AthleteDetailHeaderView class defines a custom header view for displaying athlete details.
*/
class AthleteDetailHeaderView: UIView {

    // MARK: Outlets

    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelDOB: UILabel!
    @IBOutlet private weak var labelWeight: UILabel!
    @IBOutlet private weak var labelHeight: UILabel!
    @IBOutlet private weak var imageViewPicture: UIImageView!

    // MARK: Methods

    /**
     Configures the header view with athlete data.
     - Parameter athlete: The athlete data to be displayed.
     */
    func configure(_ athlete: AthleteResponse) {
        labelName.text      = "Name: \(athlete.name ?? "")"
        labelDOB.text       = "DOB: \(athlete.dateOfBirth ?? "")"
        labelHeight.text    = "Height: \(athlete.height ?? 0)"
        labelWeight.text    = "Weight: \(athlete.weight ?? 0)"

        if let id = athlete.athleteId {
            let url = "https://ocs-test-backend.onrender.com/athletes/\(id)/photo"
            imageViewPicture.loadImageUsingCache(withUrl: url)
        }
    }
}
