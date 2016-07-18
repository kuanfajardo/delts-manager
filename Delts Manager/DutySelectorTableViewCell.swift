//
//  DutySelectorTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/18/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class DutySelectorTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var duty: Duty?
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
}
