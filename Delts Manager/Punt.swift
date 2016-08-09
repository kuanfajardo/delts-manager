//
//  Punt.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import Foundation

class Punt {
    // MARK: Properties
    
    var name: String
    var date: NSDate
    var dateString: String {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MM/dd"
            return dateFormatter.stringFromDate(date)
        }
    }
    var givenBy: String
    var status: PuntStatus
    var slave: String

    
    // MARK: Init
    init(slave: String, name: String, date: NSDate, givenBy: String, status: PuntStatus) {
        self.slave = slave
        self.name = name
        self.date = date
        self.givenBy = givenBy
        self.status = status
    }
}


enum PuntStatus {
    case JustThere
    case Madeup
    case MakeupRequested
}