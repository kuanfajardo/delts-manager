//
//  SettingsSwitchTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/30/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class SettingsSwitchTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    // MARK: Actions
    @IBAction func switchFlipped(sender: UISwitch) {
        //
    }
}
