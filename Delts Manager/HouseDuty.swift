//
//  HouseDuty.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/8/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

struct HouseDuty {
    var name: String
    var days: [DutyAvailability]
    
    init(name: String, days: [DutyAvailability]) {
        self.name = name
        self.days = days
    }
}

enum DutyAvailability: String {
    case Open = "O"
    case Selected = "S"
    case Taken = "T"
    case Unavailable = "U"
}
