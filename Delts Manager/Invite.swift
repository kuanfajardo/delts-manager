//
//  Invite.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import Foundation

class Invite {
    // MARK: Properties
    var inviteName: String?
    var deltName: String?
    
    // MARK: Life Cycle
    convenience init(invite: String) {
        self.init(invite: invite, from: Constants.defaults.stringForKey(Constants.DefaultsKeys.Name)!)
    }
    
    init(invite: String, from: String) {
        self.inviteName = invite
        self.deltName = from
    }
}
