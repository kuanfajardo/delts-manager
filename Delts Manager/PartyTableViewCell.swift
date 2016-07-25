//
//  PartyTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: Properties
    var event: Event?
}
