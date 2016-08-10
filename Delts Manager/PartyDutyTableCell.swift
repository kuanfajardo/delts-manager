//
//  PartyDutyTableCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/10/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PartyDutyTableCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var slaveLabel: UILabel!
    @IBOutlet weak var dutyLabel: UILabel!
    
    // MARK: Properties
    var duty: Duty?
}
