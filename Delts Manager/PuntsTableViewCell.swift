//
//  PuntsTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PuntsTableViewCell: UITableViewCell {
    // MARK: Properties
    var punt: Punt?
    
    // MARK: Outlets
    @IBOutlet weak var puntLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkoffImageView: UIImageView!
}
