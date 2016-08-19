//
//  Duty.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class Duty {
    // MARK: Properties
    
    // All Duties
    var slave: String
    var name: String
    var type: Constants.DutyType
    var status: DutyStatus
    var id : Int
    
    // House Duties
    var date: NSDate?
    var dateString: String? {
        if let date = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MM/dd"
            return dateFormatter.stringFromDate(date)
        }
        
        return nil
    }
    
    // Party Duties
    var startTime: NSDate?
    var duration: Int?
    
    
    // MARK: Init
    // House
    init(slave: String, name: String, id: Int, type: Constants.DutyType, date: NSDate, status: DutyStatus) {
        self.slave = slave
        self.name = name
        self.id = id
        self.date = date
        self.status = status
        self.type = type
    }
    
    // Party
    init(slave: String, name: String, id: Int, type: Constants.DutyType, status: DutyStatus, startTime: NSDate, duration: Int) {
        self.slave = slave
        self.name = name
        self.id = id
        self.startTime = startTime
        self.status = status
        self.type = type
        self.duration = duration
    }
  
}

enum DutyStatus {
    case Complete
    case Pending
    case Incomplete
    case Punted
}
