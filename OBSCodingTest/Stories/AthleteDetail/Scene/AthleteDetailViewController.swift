//
//  AthleteDetailViewController.swift
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

protocol AthleteDetailDisplayLogic: NSObjectProtocol {
    func displayAthletesResults(viewModel: AthleteDetail.ViewModel)
}

class AthleteDetailViewController: UIViewController, AthleteDetailDisplayLogic {
    
    // MARK: - Properties
    
    // The athlete whose details are being displayed
    private var athlete: AthleteResponse!
    
    // The athlete's results
    private var athleteResults: [AthleteResultResponse]?
    
    // Identifier for the medal cell
    private let medalCellIdentifier = "Medal"
    
    // Identifier for the bio cell
    private let bioCellIdentifier = "Bio"
    
    // The interactor that handles the business logic
    var interactor: AthleteDetailBusinessLogic?
    
    // The router that handles navigation between screens
    var router: (NSObjectProtocol & AthleteDetailRoutingLogic & AthleteDetailDataPassing)?
    
    // Outlets
    @IBOutlet private weak var athleteTableView: UITableView!
    @IBOutlet private weak var athleteHeaderView: AthleteDetailHeaderView!
    
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup Clean Code Design Pattern
    
    private func setup() {
        let viewController = self
        let interactor = AthleteDetailInteractor()
        let presenter = AthleteDetailPresenter()
        let router = AthleteDetailRouter()
        
        // Assign dependencies
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
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the athlete details in the header view
        athlete = (interactor as! AthleteDetailDataStore).athlete
        athleteHeaderView.configure(athlete)
        
        //setting title to athlete name
        title = athlete.name
        
        // Fetch the athlete's results
        Task { await interactor?.fetchAthleteResults(athleteID: athlete.athleteId ?? "") }
    }
    
    // MARK: - AthleteDetailDisplayLogic
    
    func displayAthletesResults(viewModel: AthleteDetail.ViewModel) {
        // Update the results and reload the table view
        athleteResults = viewModel.results
        athleteTableView.reloadData()
    }
    
    // MARK: - Private methods
    
    // Configure the bio cell
    private func configureBioCell(at indexPath: IndexPath) -> UITableViewCell {

        guard let cell = athleteTableView.dequeueReusableCell(
            withIdentifier: bioCellIdentifier,
            for: indexPath
        ) as? AthleteBioCell else {
            fatalError("Cannot dequeue cell with identifier \(bioCellIdentifier)")
        }
        cell.configure(athlete)
        return cell
    }
    
    // Configure the medal cell
    private func configureMedalCell(at indexPath: IndexPath) -> UITableViewCell {

        guard let cell = athleteTableView.dequeueReusableCell(
            withIdentifier: medalCellIdentifier, for: indexPath
        ) as? AthleteMedalCell else {
            fatalError("Cannot dequeue cell with identifier \(bioCellIdentifier)")
        }
        cell.configure(athleteResults![indexPath.item])
        return cell
    }
}

/**
The AthleteDetailViewController class conforms to UITableViewDelegate and UITableViewDataSource protocols
to provide table view data and configuration to display athlete's information including medals and bio.
*/
extension AthleteDetailViewController: UITableViewDelegate, UITableViewDataSource {
    /**
     Returns the number of sections in the table view.
     - Parameter tableView: The table view requesting this information.
     - Returns: The number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        athleteResults != nil ? 2 : 1
    }

    /**
     Asks the data source to return the number of rows in a given section of a table view.
     - Parameters:
     - tableView: The table view requesting this information.
     - section: An index number identifying a section in tableView.
     - Returns: The number of rows in section.
     */
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        section == 1 ? 1 : (athleteResults?.count ?? 1)
    }

    /**
     Asks the data source for a cell to insert in a particular location of the table view.
     - Parameters:
     - tableView: A table view requesting the cell.
     - indexPath: An index path that locates a row in tableView.
     - Returns: An object inheriting from UITableViewCell that the table view can use for the specified row.
     */
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell

        if indexPath.section == 0, isMedalSectionAvailable {
            cell = configureMedalCell(at: indexPath)
        } else {
            cell = configureBioCell(at: indexPath)
        }
        
        return cell
    }

    /**
     Asks the delegate for the height to use for the header of a particular section.
     - Parameters:
     - tableView: The table view requesting this information.
     - section: An index number identifying a section of tableView.
     - Returns: A nonnegative floating-point value that specifies the height (in points) of the section header.
     */
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    /**
     Asks the delegate for the header title of a particular section.
     - Parameters:
     - tableView: The table view requesting this information.
     - section: An index number identifying a section of tableView.
     - Returns: A string to use as the title of the section header.
     */
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        (section == 0 && isMedalSectionAvailable) ? "Medals" : "Bio"
    }
}

// MARK: Computed Properties

extension AthleteDetailViewController {
    /**
     A Boolean value indicating whether medal section is available or not.
     */
    private var isMedalSectionAvailable: Bool {
        athleteResults != nil
    }
}
