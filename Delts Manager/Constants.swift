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
    
    static func userAuthorized(role: Int) -> Bool {
        let roles = Constants.defaults.arrayForKey(Constants.DefaultsKeys.Roles) as! [Int]
        
        if roles.indexOf(role) != nil {
            return true
        } else {
            return false
        }
    }
    
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
        static let Token = "Token"
        static let Name = "Name"
        static let ID = "ID"
        static let Email = "Email"
        static let Roles = "Roles"
        static let Notifications = "Notifications"
        static let DutyReminders = "Duty Reminders"
        static let DutyTime = "Duty Reminder Time"
        static let PuntMakupPosted = "Punt Makeup Posted Notifications"
        static let CheckoffNotification = "Checkoff Notifications"
        static let PuntNotification = "Punt Notifications"
        static let Punts = "Punts"
        static let ScheduleEnabled = "Schedule Enabled"
        static let Duties = "Duties"
    }

    
    struct Colors {
        static let deltsYellow = UIColor(red:1.0, green:0.87004060520000004, blue:0.50798801100000002, alpha:1.0)
        static let deltsLightYellow = UIColor(red:1.0, green:0.87004060520000004, blue:0.50798801100000002, alpha:0.5)
        static let deltsDarkPurple = UIColor(red:0.52955204398288358, green:0.11682364710210935, blue:1, alpha:1)
        static let deltsPurple = UIColor(red:0.52955204398288358, green:0.11682364710210935, blue:1, alpha:0.64310344827586208)
        static let deltsLightPurple = UIColor(red:0.52955204398288358, green:0.11682364710210935, blue:1, alpha:0.32)

    }
    
    struct Fonts {
        static let systemThin = "HelveticaNeue-Thin"
        static let systemLight = "HelveticaNeue-Light"
    }
    
    struct Photos {
        static var Overview: UIImage {
            return UIImage(named: "OverviewIcon")!
        }
        
        static var Duty: UIImage {
            return UIImage(named: "DutyIcon")!
        }
        
        static var Punt: UIImage {
            return UIImage(named: "PuntIcon")!
        }
        
        static var Settings: UIImage {
            return UIImage(named: "SettingsIcon")!
        }
        
        static var BlackCircle: UIImage {
            return UIImage(named: "first")!
        }
        
        static var Manager: UIImage {
            return UIImage(named: "ManagerIcon")!
        }
        
        static var Party: UIImage {
            return UIImage(named: "PartyIcon")!
        }
        
        static var GreenCheck: UIImage {
            return UIImage(named: "Green Check")!
        }
        
        static var RedAttention: UIImage {
            return UIImage(named: "Red Attention")!
        }
        
        static var DarkRedAttention: UIImage {
            return UIImage(named: "Dark Red Attention")!
        }
        
        static var Cancel: UIImage {
            return UIImage(named: "Red Cancel")!
        }
        
        static var Clock: UIImage {
            return UIImage(named: "Yellow Clock")!
        }
        
        static var WhiteAttention: UIImage {
            return UIImage(named: "White Attention")!
        }
        
        static var Check: UIImage {
            return UIImage(named: "Check")!
        }
        
        static var One: UIImage {
            return UIImage(named: "One")!
        }
        
        static var Two: UIImage {
            return UIImage(named: "Two")!
        }
        
        static var Three: UIImage {
            return UIImage(named: "Three")!
        }
        
        static var Four: UIImage {
            return UIImage(named: "Four")!
        }
        
        static var Five: UIImage {
            return UIImage(named: "Five")!
        }
        
        static var Six: UIImage {
            return UIImage(named: "Six")!
        }
        
        static var Seven: UIImage {
            return UIImage(named: "Seven")!
        }
        
        static var Eight: UIImage {
            return UIImage(named: "Eight")!
        }
        
        static var Nine: UIImage {
            return UIImage(named: "Nine")!
        }
        
        static var SmileyFace: UIImage {
            return UIImage(named: "Smiley")!
        }
        
        static var Calendar: UIImage {
            return UIImage(named: "Calendar")!
        }
        
        static var GreenCircle: UIImage {
            return UIImage(named: "Green Circle")!
        }
        
        static var YellowCircle: UIImage {
            return UIImage(named: "Yellow Circle")!
        }
        
        static var RedCircle: UIImage {
            return UIImage(named: "Red Circle")!
        }
        
        static var WhiteCircle: UIImage {
            return UIImage(named: "White Circle")!
        }
        
        static var PurpleCircle: UIImage {
            return UIImage(named: "Purple Circle")!
        }
    }
    
    struct Identifiers {
        
        struct TableViewCells {
            static let DutyTableViewCell = "DutyTableViewCell"
            static let PuntTableViewCell = "PuntTableViewCell"
            static let SettingsTextCell = "SettingsText"
            static let SettingsSwitchCell = "SettingsSwitch"
            static let DutySelectorCell = "DutySelector"
            static let PlainCell = "Plain"
            static let EventPropertyCell = "EventProperty"
            static let EventDutyCell = "EventDuty"
            static let EventDutyTimeCell = "EventDutyTime"
            static let AddCustomDutyCell = "AddCustomDuty"
            static let CustomEventDutyCell = "CustomDuty"
            static let PartyTableViewCell = "PartyCell"
            static let DutyCheckoffCell = "DutyCheckoffCell"
            static let PuntAdminCell = "PuntAdminCell"
            static let NoDutiesCell = "NoDutiesCell"
            static let NoPuntsCell = "NoPuntsCell"
            static let NoEventsCell = "NoEventsCell"
            static let InviteCell = "InviteCell"
            static let NewInviteCell = "NewInviteCell"
            static let ExpandingDutySelectorCell = "ExpandingDutySelector"
            static let NewDutySelectorCell = "NewDutySelector"
            static let PartyDutyCell = "PartyDutyCell"
            static let PuntedPersonCell = "PuntedPersonCell"
        }
        
        struct Controllers {
            static let LoginController = "Login"
            static let TabController = "TabController"
            static let BouncingController = "Bouncing"
            static let EventNameController = "EventName"
            static let StartTimeController = "StartTime"
            static let EndTimeController = "EndTime"
            static let DutyChooserController = "DutyChooser"
            static let DutyTimeChooserController = "DutyTimeChooser"
            static let NewPartyController = "New Party"
            static let DutySelectorController = "DutySelectorController"
            static let NewPuntController = "New Punt Controller"
            static let NewPuntCommentController = "NewPuntCommentController"
        }
        
        struct Segues {
            static let ChangePasswordSegue = "ChangePassword"
            static let UserDutyDetailSegue = "UserDutyDetail"
            static let CheckerDutyDetailSegue = "CheckerDutyDetail"
            static let UserPuntDetailSegue = "UserPuntDetail"
            static let AdminPuntDetailSegue = "AdminPuntDetail"
        }
        
        struct TextFields {
            static let EmailField = "Email Field"
            static let PasswordField = "Password Field"
            static let NewPasswordField = "New Password"
            static let RepeatPasswordField = "Repeat Password"
        }
    }
    
    struct Roles {
        static let User = 0
        static let Checker = 1
        static let HouseManager = 2
        static let BouncingChair = 3
        static let HonorBoard = 4
        static let Admin = 5
    }
    
    enum DutyType: String {
        case House = "House"
        case Party = "Party"
    }
    
    // MARK: Networking
    struct AlamoKeys {
        static let ApiKey = "api_key"
        static let Token = "token"
        static let Email = "email"
        static let DutyID = "duty_id"
        static let Claim = "claim"
        static let Comments = "comments"
        static let UserID = "user_id"
        static let PuntedID = "punted_id"
        static let Username = "username"
        static let Realm = "realm"
        static let Nonce = "nonce"
        static let Opaque = "opaque"
        static let Method = "method"
        static let URI = "uri"
        static let Response = "response"
        
    }
    
    struct AlamoValues {
        static let ApiKey = "3Ha63GR28fbkknu29HUb1Qk3RO2NR9ga"
        static let Token = "0"
    }
    
    struct Networking {
        static let BaseURL = "http://dtd.mit.edu/api/v1/"
        
        struct Methods {
            // Account Methods
            static let AccountInfo = "account/"
            static let AccountDuties = "account/duties"
            static let AccountPunts = "account/punts"
            static let AccountPostCheckoff = "account/checkoff"
            static let AccountStats = "/account/stats"
            
            // Scheduling Methods
            static let GetHouseDuties = "scheduling/house_duties"
            static let HouseDutyNames = "scheduling/house_duty_names"
            static let UpdateHouseDuty = "scheduling/update_duty"
            
            // Manager Methods
            static let ManagerAllDuties = "manager/duties"
            static let ManagerPunts = "manager/punts"
            static let ManagerRequestedCheckoffs = "manager/duty_checkoffs"
            static let ManagerCheckoffDuty = "manager/checkoff_duty"
            static let ManagerPunt = "manager/punt"
            static let ManagerUsers = "manager/users"
            
            // Authentication Methods
            static let Authenticate = "authenticate/"
            
            // Not in API yet
            static let AccountRequestPuntMakeup = "account/punt_makeup"
            static let ManagerDeletePunt = "manager/delete_punt"
            static let ManagerMakeupPunt = "manager/makeup_punt"

        }
    }
}
