//
//  PartyInviteTableViewCell.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PartyInviteTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var inviteTextField: UITextField!
    @IBOutlet weak var deltTextField: UITextField!
    
    // MARK: Properties
    var invite: Invite?
}
