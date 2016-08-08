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
                    ("Change Password", "Text", "")
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
            let identifier = Constants.Identifiers.TableViewCells.SettingsTextCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SettingsTextTableViewCell
            
            cell.settingLabel.text = settingName
            cell.descriptionLabel.text = (settingDescription as! String)
            
            if settingName == "Email" {
                cell.userInteractionEnabled = false
            }
            
            return cell
            
        case "Switch":
            let identifier = Constants.Identifiers.TableViewCells.SettingsSwitchCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SettingsSwitchTableViewCell
            
            cell.settingLabel.text = settingName
            cell.settingSwitch.on = (settingDescription as! Bool)
            cell.settingSwitch.tintColor = UIColor.flatMagentaColor()//Constants.Colors.deltsDarkPurple
            cell.settingSwitch.onTintColor = UIColor.flatMagentaColor()//Constants.Colors.deltsDarkPurple
            cell.settingSwitch.tag = indexPath.row
            cell.settingSwitch.addTarget(self, action: #selector(switchFlipped), forControlEvents: .ValueChanged)
            cell.selectionStyle = .None
            
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier(Constants.Identifiers.TableViewCells.SettingsTextCell)!
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 1 {
            performSegueWithIdentifier(Constants.Identifiers.Segues.ChangePasswordSegue, sender: self)
        } else if indexPath.section == 2 {
            let alertController = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Logout", style: .Default, handler: { (alert: UIAlertAction) in
                
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                
                let loginController = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.LoginController) as! LoginViewController
                
                self.presentViewController(loginController, animated: false, completion: nil)
                return
            }))
            
            self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func switchFlipped(sender: UISwitch) {
        Constants.defaults.setBool(sender.on, forKey: keys[sender.tag])
        Constants.defaults.synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    
    
}
