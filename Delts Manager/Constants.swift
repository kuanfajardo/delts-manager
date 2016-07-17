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
    
    static var defaults: NSUserDefaults {
        get {
            return NSUserDefaults.standardUserDefaults()
        }
    }
    
    // MARK: User Info
    enum Status: String {
        case Completed = "Completed"
        case Pending = "Pending"
        case Incomplete = "Incomplete"
        case Punted = "Punted"
        
        // TODO: Implement init so can use in Duty
        /*init(status: String) {
            
        }*/
    }
    
    // TODO: Move to settings view controller viewDidLoad
    struct Settings {
        static var email = "jfajardo@mit.edu"
        static var password = "yeet" // FOR DEBUG ONLY
        static var notificationsOn = true
        static var dutiesReminders = true
        static var dutyReminderTime = "08:00"
        static var puntMakeupPostedNotificationsOn = true
        static var checkoffNotificationsOn = false
        static var puntNotificationsOn = true
    }
    
    struct DefaultsKeys {
        static let LoggedIn = "Logged In"
        static let Email = "Email"
        static let Notifications = "Notifications"
        static let DutyReminders = "Duty Reminders"
        static let DutyTime = "Duty Reminder Time"
        static let PuntMakupPosted = "Punt Makeup Posted Notifications"
        static let CheckoffNotification = "Checkoff Notifications"
        static let PuntNotification = "Punt Notifications"
        static let CheckoffEnabled = "Checkoff Enabled"
        static let Punts = "Punts"
        static let ScheduleEnabled = "Schedule Enabled"
    }

    
    struct Colors {
        static let deltsYellow = UIColor(red:1.0, green:0.87004060520000004, blue:0.50798801100000002, alpha:1.0)
        static let deltsLightYellow = UIColor(red:1.0, green:0.87004060520000004, blue:0.50798801100000002, alpha:0.5)
        static let deltsPurple = UIColor(red:0.52955204398288358, green:0.11682364710210935, blue:1, alpha:0.64310344827586208)
        static let deltsLightPurple = UIColor(red:0.52955204398288358, green:0.11682364710210935, blue:1, alpha:0.32)

    }
    
    struct Fonts {
        static let systemThin = "HelveticaNeue-Thin"
        static let systemLight = "HelveticaNeue-Light"
    }
    
    struct Photos {
        static let Overview = "OverviewIcon"
        static let Duty = "DutyIcon"
        static let Punt = "PuntIcon"
        static let Settings = "SettingsIcon"
    }
    
    struct Identifiers {
        
        struct TableViewCells {
            static let DutyTableViewCell = "DutyTableViewCell"
            static let PuntTableViewCell = "PuntTableViewCell"
            static let SettingsTextCell = "SettingsText"
            static let SettingsSwitchCell = "SettingsSwitch"
        }
        
        struct Controllers {
            static let TabController = "TabController"
        }
        
        struct Segues {
            static let ChangePasswordSegue = "ChangePassword"
        }
        
        struct TextFields {
            static let EmailField = "Email Field"
            static let PasswordField = "Password Field"
            static let NewPasswordField = "New Password"
            static let RepeatPasswordField = "Repeat Password"
        }
    }
}
