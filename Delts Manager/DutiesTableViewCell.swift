//
//  DutiesTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class DutiesTableViewCell: MGSwipeTableCell {
    
    // MARK: Properties
    var duty: Duty?
    
    // MARK: Outlets
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
}
