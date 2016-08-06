//
//  PuntAdminTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/1/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PuntAdminTableViewCell: MGSwipeTableCell {
    
    // MARK: Properties
    var punt: Punt?
    
    // MARK: Outlets
    @IBOutlet weak var puntLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var slaveLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
}