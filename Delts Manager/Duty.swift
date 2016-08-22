//
//  Duty.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import Freddy

class Duty {
    // MARK: Properties
    
    // All Duties
    var slave: String
    var name: String
    var type: Constants.DutyType
    var status: DutyStatus
    var id : Int
    var description: String = ""
    var checker: String = "N/A"
    var checkComments = "---"
    
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
    convenience init(json: JSON, type: String) throws {
        let dutyID = try json.int("duty_id")
        let dutyDateString = try json.string("date")
        let dutyName = try json.string("duty_name")
        let dutyDescription = try json.string("description")
        let dutyStatusString = try json.string("status")
        
        var checkerName: String
        var checkComments: String
        var dutySlave: String
        
        switch type {
        case "User":
            dutySlave = Constants.defaults.stringForKey(Constants.DefaultsKeys.Name)!
            checkerName = try json.string("checker")
            checkComments = try json.string("check_comments")
            break
        case "Checker":
            dutySlave = try json.string("duty_user_name")
            checkerName = "N/A"
            checkComments = ""
        case "Admin":
            dutySlave = try json.string("duty_user_name")
            checkerName = try json.string("checker")
            checkComments = try json.string("check_comments")
        default:
            dutySlave = "Delt"
            checkerName = ""
            checkComments = ""
        }
        
        self.init(slave: dutySlave, name: dutyName, id: dutyID, description: dutyDescription, checker: checkerName, comments: checkComments, status: dutyStatusString, date: dutyDateString)
    }
    
    
    // LAZY CONVENIENCE INIT
    convenience init() {
        self.init(slave: "Delt", name: "Duty", id: 0, description: "", checker: "N/A", comments: "")
    }
    
    // MAIN CONVENIENCE INIT
    convenience init(slave: String, name: String, id: Int, description: String, checker: String, comments: String, status: String, date: String) {
        
        // Calculating Status
        let realStatus: DutyStatus
        
        switch status {
        case "Complete":
            realStatus = .Complete
            break
        case "Pending":
            realStatus = .Pending
            break
        case "Incomplete":
            realStatus = .Incomplete
            break
        case "Punted":
            realStatus = .Punted
            break
        default:
            realStatus = .Incomplete
        }
        
        // Calculating Date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let realDate = dateFormatter.dateFromString(date)!
        
        // Call other init
        self.init(slave: slave, name: name, id: id, description: description, checker: checker, comments: comments, status: realStatus, date: realDate)
        
    }
    
    // MAIN INIT
    init(slave: String, name: String, id: Int, description: String, checker: String, comments: String, type: Constants.DutyType = Constants.DutyType.House, status: DutyStatus = DutyStatus.Incomplete, date: NSDate = NSDate()) {
        self.slave = slave
        self.name = name
        self.id = id
        self.description = description
        self.checker = checker
        self.checkComments = comments
        self.type = type
        self.status = status
        self.date = date
    }
    
    
    // OLD INITS
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
