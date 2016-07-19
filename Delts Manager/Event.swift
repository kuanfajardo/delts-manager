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
    var startTime: NSDate
    var endTime: NSDate
    var duties: [Duty]
    var people: [String]
    
    init(name: String, startTime: NSDate, endTime: NSDate, duties: [Duty], people: [String]) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.duties = duties
        self.people = people
    }
}
