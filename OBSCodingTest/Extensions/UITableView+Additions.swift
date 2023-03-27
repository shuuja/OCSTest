//
//  UITableView+Additions.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import Foundation
import UIKit

extension UITableView {

    /**
     Registers an array of table view cell types for use in the table view.
     
     - Parameter cells: An array of table view cell types to register.
     */
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach({
            register(UINib(nibName: String(describing: $0),
                           bundle: nil),
                     forCellReuseIdentifier: String(describing: $0))
        })
    }

    /**
     Registers an array of table view header/footer view types for use in the table view.
     
     - Parameter headerFooter: An array of table view header/footer view types to register.
     */
    func registerHeaderFooter(_ headerFooter: [UITableViewHeaderFooterView.Type]) {
        headerFooter.forEach({
            register(UINib(nibName: String(describing: $0),
                           bundle: nil),
                     forHeaderFooterViewReuseIdentifier: String(describing: $0))
        })
    }

    /**
     Returns a reusable table view cell object for the specified type and index path.
     
     - Parameters:
        - type: The type of the cell to retrieve.
        - indexPath: The index path specifying the location of the cell.
     
     - Returns: A reusable table view cell object of the specified type.
     */
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(
            withIdentifier: String(describing: type),
            for: indexPath
        ) as! T
        return cell
    }

    /**
     Returns a reusable table view header/footer view object for the specified type.
     
     - Parameter type: The type of the header/footer view to retrieve.
     
     - Returns: A reusable table view header/footer view object of the specified type, or `nil` if no such object exists in the reuse queue.
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: type)
        ) as? T
    }
}

