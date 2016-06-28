//
//  Constants.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

// MARK: Constants

struct Constants {
    // MARK: User Info
    struct UserInfo {
        static let email = "jfajardo@mit.edu"
        static let password = "yeet"
    }
    
    enum Status: String {
        case Completed = "Completed"
        case Pending = "Pending"
        case Incomplete = "Incomplete"
        case Punted = "Punted"
        
        // TODO: Implement init so can use in Duty
        /*init(status: String) {
            
        }*/
    }
    
}
