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
    var settings = [
        ["Email", "Password"],
        ["Toggle Notifications", "Duties Reminders","Punt Makeup Posted", "Checkoffs", "Punts"],
        ["Logout"]
    ]
    
    var sectionTitles = ["Account Settings", "Notifications", "Logout"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: UITableViewDataSource Protocol
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SettingsText"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SettingsTextTableViewCell
        
        cell.settingLabel.text = settings[indexPath.section][indexPath.row]
        cell.descriptionLabel.text = ""

        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
