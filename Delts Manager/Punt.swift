//
//  Punt.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import Foundation
import Freddy

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
    var id: Int
    var comment: String = ""
    var makeupGivenBy: String = "---"
    var makeupDate: NSDate = NSDate()
    var makeupComment: String = ""

    
    // MARK: Init
    // JSON INIT
    convenience init(json: JSON, type: String) throws {
        let id = try json.int("punt_id")
        let dateString = try json.string("timestamp")
        let givenBy = try json.string("given_by")
        let comments = try json.string("comment   ")
        let makeupGivenBy = try json.string("makeup_given_by")
        let makeupDateString = try json.string("makeup_timestamp")
        let makeupComment = try json.string("makeup_comment")
        
        var puntSlave: String
        
        if type == "Admin" {
            puntSlave = try json.string("punted_user_name")
        } else {
            puntSlave = Constants.defaults.stringForKey(Constants.DefaultsKeys.Name)!
        }
        
        self.init(slave: puntSlave, id: id, givenBy: givenBy, comment: comments, makeupGivenBy: makeupGivenBy, makeupComment: makeupComment, dateString: dateString, makeupDateString: makeupDateString)
    }
    
    // LAZY INIT
    convenience init() {
        self.init(slave: "Delt", id: 0, givenBy: "Delts Manager", comment: "u dumb", makeupGivenBy: "---", makeupComment: "---")
    }
    
    
    // MAIN CONV INIT
    convenience init(slave: String, id: Int, givenBy: String, comment: String, makeupGivenBy: String, makeupComment: String, dateString: String, makeupDateString: String, name: String = "Punt") {
        
        // Calculate Dates
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let realDate = dateFormatter.dateFromString(dateString)!
        let realMakeupDate = dateFormatter.dateFromString(makeupDateString)!
        
        // Calculate Status
        let realStatus: PuntStatus
        if makeupDateString == "0000-00-00 00:00:00" {
            realStatus = .JustThere
        } else {
            realStatus = .Madeup
        }
        
        self.init(slave: slave, id: id, givenBy: givenBy, comment: comment, makeupGivenBy: makeupGivenBy, makeupComment: makeupComment, date: realDate, makeupDate: realMakeupDate, status: realStatus, name: name)
    }
    
    
    // MAIN INIT
    init(slave: String, id: Int, givenBy: String, comment: String, makeupGivenBy: String, makeupComment: String, date: NSDate = NSDate(), makeupDate: NSDate = NSDate(), status: PuntStatus = PuntStatus.JustThere, name: String = "Punt") {
        self.slave = slave
        self.id = id
        self.givenBy = givenBy
        self.comment = comment
        self.makeupGivenBy = makeupGivenBy
        self.makeupComment = makeupComment
        self.date = date
        self.makeupDate = makeupDate
        self.status = status
        self.name = name
    }
    
    
    init(slave: String, name: String, id: Int, date: NSDate, givenBy: String, status: PuntStatus) {
        self.slave = slave
        self.name = name
        self.id = id
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