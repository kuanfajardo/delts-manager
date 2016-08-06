//
//  DutyCheckoffTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/29/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class DutyCheckoffTableViewCell: MGSwipeTableCell {
    
    // MARK: Properties
    var duty: Duty?
    
    // MARK: Outlets
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var slaveLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
}
