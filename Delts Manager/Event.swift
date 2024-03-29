//
//  Event.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/19/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class Event {
    // MARK: Properties
    var name: String
    var startTime: NSDate?
    var startTimeString: String? {
        if let date = startTime {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MM/dd"
            return dateFormatter.stringFromDate(date)
        }
        
        return nil
    }
    var endTime: NSDate
    var duties: [Duty]
    var times: [String]
    var invites: [Invite]
    
    init(name: String, startTime: NSDate, endTime: NSDate, duties: [Duty], times: [String]) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.duties = duties
        self.times = times
        self.invites = [Invite]()
    }
}
