//
//  Duty.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class Duty: NSObject, NSCoding {
    // MARK: Properties
    
    // All Dutie
    var name: String
    var type: Constants.DutyType
    var status: String // TODO: implement as Const.Status (init all three methods below)
    
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
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let typeKey = "type"
        static let dateKey = "date"
        static let statusKey = "status"
    }
    
    // MARK: Init
    init(name: String, type: Constants.DutyType, date: NSDate, status: String) {
        self.name = name
        self.date = date
        self.status = status
        self.type = type
        
        super.init()
    }
    
    init(name: String, type: Constants.DutyType, status: String, startTime: NSDate, duration: Int) {
        self.name = name
        self.startTime = startTime
        self.status = status
        self.type = type
        self.duration = duration
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(type.rawValue, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(status, forKey: PropertyKey.statusKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let typeRaw = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        let type = Constants.DutyType(rawValue: typeRaw)!
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let status = aDecoder.decodeObjectForKey(PropertyKey.statusKey) as! String
        
        self.init(name: name, type: type, date: date, status: status)
    }
}
