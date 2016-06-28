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
    
    var name: String
    var date: NSDate
    // TODO: implement as Const.Status (init all three methods below)
    var status: String
    
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let dateKey = "date"
        static let statusKey = "status"
    }
    
    // MARK: Init
    init(name: String, date: NSDate, status: String) {
        self.name = name
        self.date = date
        self.status = status
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(status, forKey: PropertyKey.statusKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let status = aDecoder.decodeObjectForKey(PropertyKey.statusKey) as! String
        
        self.init(name: name, date: date, status: status)
    }
}
