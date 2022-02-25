//
//  ContestCell.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 27/01/22.
//

import Foundation
import UIKit

class ContestCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    static let reuseidentifier = "ContestCell"
    
    /// set contest data
    func setData(contestData: Contests) {
        lblName.text = contestData.name
        lblSite.text = contestData.site
        if let startTime = contestData.start_time {
            lblStartDate.text = startTime.convertToDateFormat()
        }
        selectionStyle = .none
    }
}
