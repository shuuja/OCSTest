//
//  AthleteMedalsView.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 27/03/2023.
//

import UIKit
/**
The AthleteMedalsView class defines a custom stack view for displaying athlete medals.
*/
class AthleteMedalsView: UIStackView {

    // MARK: Outlets
    @IBOutlet private weak var labelGoldCount: UILabel!
    @IBOutlet private weak var labelBronzeCount: UILabel!
    @IBOutlet private weak var labelSilverCount: UILabel!

    // MARK: Methods
    /**
     Configures the stack view with athlete medals data.
     - Parameter result: The athlete medals data to be displayed.
     */
    func configure(_ result: AthleteResultResponse) {
        labelGoldCount.superview?.isHidden      = !(result.gold != 0)
        labelBronzeCount.superview?.isHidden    = !(result.bronze != 0)
        labelSilverCount.superview?.isHidden    = !(result.silver != 0)
    }
}
