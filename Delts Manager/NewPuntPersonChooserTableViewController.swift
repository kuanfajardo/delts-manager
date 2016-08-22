//
//  NewPuntPersonChooserTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/22/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class NewPuntPersonChooserTableViewController: UITableViewController {
    // MARK: Properties
    var allSlaves = [String]()
    var selectedSlaves = [String]()
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.bounces = false

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        print("yetu loaded")
        
        loadSlaves()
        loadSampleSlaves()
    }
    
    func loadSampleSlaves() {
        allSlaves += ["Juan", "Tim Plump", "Sam Resnick", "Sam Ravnaas", "Brennan Lee", "Malik Coville", "Adam TS", "Talla Babou", "Jeremy Sands", "Tim Henry", "Alex Lynch", "Erick Friis", "Ini OG", "Jake Stein", "Subby OBIG", "David Merchan", "John Crack", "Isaac the Slut", "Jackson Wang", "RIP Andre"]
    }
    
    func loadSlaves() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!
        ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.ManagerUsers))")
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.ManagerPunts), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let users = try json.array(0)
                    
                    for user in users {
                        let name = try user.string("user_name")
                        self.allSlaves.append(name)
                    }
                    
                } catch {
                    print("Error")
                }
        }

    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }

    func donePressed() {
        print(selectedSlaves)
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard indexPath.row < allSlaves.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatWatermelonColor()
            } else {
                cell.backgroundColor = UIColor.flatWatermelonColorDark()
            }
            
            cell.userInteractionEnabled = false

            return cell
        }
        
        
        let identifier = Constants.Identifiers.TableViewCells.PuntedPersonCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntedPersonTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.flatWatermelonColor()
        } else {
            cell.backgroundColor = UIColor.flatWatermelonColorDark()
        }
        
        cell.nameLabel.text = allSlaves[indexPath.row]
        
        if selectedSlaves.indexOf(allSlaves[indexPath.row]) != nil {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSlaves.count
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PuntedPersonTableViewCell
        
        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = .Checkmark
            self.selectedSlaves.append(cell.nameLabel.text!)
        } else {
            cell.accessoryType = .None
            self.selectedSlaves.removeAtIndex(self.selectedSlaves.indexOf(cell.nameLabel.text!)!)
        }
    }
}
