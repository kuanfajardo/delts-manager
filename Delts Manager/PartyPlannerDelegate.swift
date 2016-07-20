//
//  PartyPlannerDelegate.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import Foundation

@objc protocol PartyPlannerDelegate {
    optional func passNameBack(value: String)
    optional func passStartTimeBack(value: NSDate)
    optional func passEndTimeBack(value: NSDate)
    optional func passDutiesBack(value: [String])
    optional func passDutyTimesBack(value: [String])
}

protocol PartyPlannerExtendedDelegate {
    func passEventBack(value: Event)
}
