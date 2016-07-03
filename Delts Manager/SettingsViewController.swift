//
//  SettingsTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/29/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    // MARK: Outlets
    
    // MARK: Properties
    var settings: [String : [(String, String, AnyObject)]] = [:]
    
    var keys = [
        Constants.DefaultsKeys.Notifications,
        Constants.DefaultsKeys.DutyReminders,
        Constants.DefaultsKeys.PuntMakupPosted,
        Constants.DefaultsKeys.CheckoffNotification,
        Constants.DefaultsKeys.PuntNotification
    ]
    
    var sectionTitles = [
        0 : "Account Settings",
        1 : "Notifications",
        2 : "Logout"
    ]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settings = [
                "Account Settings" : [
                    ("Email", "Text", Constants.defaults.valueForKey(Constants.DefaultsKeys.Email)!),
                ],
                "Notifications" : [
                    ("Toggle Notifications", "Switch", Constants.defaults.valueForKey(Constants.DefaultsKeys.Notifications)!),
                    ("Duties Reminders", "Switch", Constants.defaults.valueForKey(Constants.DefaultsKeys.DutyReminders)!),
                    ("Punt Makeup Posted", "Switch", Constants.defaults.valueForKey(Constants.DefaultsKeys.PuntMakupPosted)!),
                    ("Checkoffs", "Switch", Constants.defaults.valueForKey(Constants.DefaultsKeys.CheckoffNotification)!),
                    ("Punts", "Switch", Constants.defaults.valueForKey(Constants.DefaultsKeys.PuntNotification)!)
                ],
                "Logout" : [
                    ("Logout", "Text", "")
                ]
        ]
    }

    // MARK: Data Source & Delegate Protocol Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let settingData = settings[sectionTitles[indexPath.section]!]![indexPath.row]
        let settingName = settingData.0
        let settingType = settingData.1
        let settingDescription = settingData.2
        
        switch settingType {
        case "Text":
            let identifier = "SettingsText"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SettingsTextTableViewCell
            
            cell.settingLabel.text = settingName
            cell.descriptionLabel.text = (settingDescription as! String)
            
            return cell
            
        case "Switch":
            let identifier = "SettingsSwitch"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SettingsSwitchTableViewCell
            
            cell.settingLabel.text = settingName
            cell.settingSwitch.on = (settingDescription as! Bool)
            cell.settingSwitch.tintColor = Constants.Colors.deltsPurple
            cell.settingSwitch.tag = indexPath.row
            cell.settingSwitch.addTarget(self, action: #selector(switchFlipped), forControlEvents: .ValueChanged)
            cell.selectionStyle = .None
            
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier("SettingsText")!
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[sectionTitles[section]!]!.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = Constants.Colors.deltsLightYellow
        header.textLabel?.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
    }

    
    func switchFlipped(sender: UISwitch) {
        print(keys[sender.tag])
        Constants.defaults.setBool(sender.on, forKey: keys[sender.tag])
        print(Constants.defaults.valueForKey(keys[sender.tag]))
        Constants.defaults.synchronize()
    }
    
    
}
