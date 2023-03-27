//
//  AthleteCollectionCell.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 26/03/2023.
//

import UIKit

class AthleteCollectionCell: UICollectionViewCell {
    
    // MARK: - Outlets

    private enum Constant {
        static let baseURL = "https://ocs-test-backend.onrender.com/athletes/"
        static let photoEndPoint = "/photo"
    }
    
    /// The label for displaying the name of the athlete.
    @IBOutlet private(set) var labelName: UILabel!
    
    /// The image view for displaying the profile picture of the athlete.
    @IBOutlet private(set) var imageViewProfile: UIImageView!
    
    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Clear the image view when the cell is reused.
        imageViewProfile.image = nil
    }

    // MARK: - Public Methods
    
    /**
     Configures the cell to display the information of the given athlete.
     
     - Parameters:
        - athlete: The athlete whose information should be displayed.
     */
    func configure(for athlete: AthleteResponse) {
        labelName.text = athlete.name
        
        // If the athlete has a profile picture, load it from the server.
        if let id = athlete.athleteId {
            let url = "\(Constant.baseURL)\(id)\(Constant.photoEndPoint)"
            imageViewProfile.loadImageUsingCache(withUrl: url)
        }
        // Otherwise, display a default thumbnail image.
        else {
            imageViewProfile.image = UIImage(named: "UserThumbnail")
        }
    }
}


