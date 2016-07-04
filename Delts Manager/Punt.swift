//
//  Punt.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import Foundation

class Punt: NSObject, NSCoding {
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
    // TODO: implement as Const.Status (init all three methods below)
    var status: String
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let dateKey = "date"
        static let givenByKey = "givenBy"
        static let statusKey = "status"
    }
    
    // MARK: Init
    init(name: String, date: NSDate, givenBy: String, status: String) {
        self.name = name
        self.date = date
        self.givenBy = givenBy
        self.status = status
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(givenBy, forKey: PropertyKey.givenByKey)
        aCoder.encodeObject(status, forKey: PropertyKey.statusKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let givenBy = aDecoder.decodeObjectForKey(PropertyKey.givenByKey) as! String
        let status = aDecoder.decodeObjectForKey(PropertyKey.statusKey) as! String
        
        self.init(name: name, date: date, givenBy: givenBy, status: status)
    }

}