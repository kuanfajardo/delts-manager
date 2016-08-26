//
//  HouseDuty.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/8/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

struct HouseDuty {
    var name: String
    var availabilities: [DutyAvailability]
    var takers: [String]
    var ids: [Int]
    
    // MAIN INIT
    init(name: String, availabilities: [DutyAvailability], slaves: [String], ids: [Int]) {
        self.name = name
        self.availabilities = availabilities
        self.takers = slaves
        self.ids = ids
    }
    
    // Convenience Init called when house duty with new name is found
    init(name: String) {
        let availabilities: [DutyAvailability] = [.Unavailable, .Unavailable, .Unavailable, .Unavailable, .Unavailable, .Unavailable, .Unavailable]

        self.init(name: name, availabilities: availabilities)
    }
    
    // Convenience init for testing ui with random duty availabilities; also used by init above to help with init overloading
    init(name: String, availabilities: [DutyAvailability]) {
        let slaves = ["", "Chaz", "Jian", "Evan", "ur mom", "Andre", ""]
        let ids = [-1, -1, -1, -1, -1, -1, -1]
        
        self.init(name: name, availabilities: availabilities, slaves: slaves, ids: ids)
    }
    
    // main function for editing each day of the house duty: since the default is unavailable, this only builds from nil up
    internal mutating func updateForDay(dayofWeek: Int, withAvailability availability: DutyAvailability, takenBy slave: String, dutyID: Int) -> Bool {
        guard 0 <= dayofWeek && dayofWeek <= 6 else {
            return false
        }
        
        self.availabilities[dayofWeek] = availability
        self.takers[dayofWeek] = slave
        self.ids[dayofWeek] = dutyID
        
        return true
    }
    
}

enum DutyAvailability: String {
    case Open = "O"
    case Selected = "S"
    case Taken = "T"
    case Unavailable = "U"
}
