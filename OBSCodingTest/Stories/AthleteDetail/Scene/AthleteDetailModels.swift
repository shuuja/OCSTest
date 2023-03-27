//
//  AthleteDetailModels.swift
//  OBSCodingTest
//
//  Created by Shuja MBP on 27/03/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// The AthleteDetail namespace, containing structs for responses and view models.
enum AthleteDetail {

    /// The response struct for athlete results.
    struct Response {
        let results: [AthleteResultResponse]
    }

    /// The view model struct for athlete results.
    struct ViewModel {
        let results: [AthleteResultResponse]
    }
}
