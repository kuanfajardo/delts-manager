//
//  ExpandingDutySelectorCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/6/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ExpandingTableView

class ExpandingDutySelectorCell: ExpandingTableViewCell {
    // MARK: Properties
    var duty: Duty?
    //var reuseId = "ExpandingDutySelector"
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!

}
