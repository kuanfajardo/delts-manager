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
    var allSlaves = [(String, Int)]()
    var selectedSlaves = [(String, Int)]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.bounces = false

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        loadSlaves()
        loadSampleSlaves()
    }
    
    func loadSampleSlaves() {
        allSlaves += [("Juan", 0), ("Tim Plump", 1), ("Sam Resnick", 2), ("Sam Ravnaas", 3), ("Brennan Lee", 4), ("Malik Coville", 5), ("Adam TS", 6), ("Talla Babou", 7), ("Jeremy Sands", 8), ("Tim Henry", 10), ("Alex Lynch", 11), ("Erick Friis", 12), ("Ini OG", 13), ("Jake Stein", 14), ("Subby OBIG", 15), ("David Merchan", 16), ("John Crack", 17), ("Isaac the Slut", 18), ("Jackson Wang", 19), ("RIP Andre", 20)]
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
                        let id = try user.int("user_id")
                        self.allSlaves.append((name, id))
                    }
                    
                } catch {
                    print("Error in loadSlaves")
                }
        }

    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }

    func donePressed() {
        let identifier = Constants.Identifiers.Controllers.NewPuntCommentController
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! NewPuntCommentViewController
        
        controller.slaves = self.selectedSlaves
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func cancel() {
        self.navigationController?.popViewControllerAnimated(true)
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
        
        cell.nameLabel.text = allSlaves[indexPath.row].0
        cell.accessoryType = .None
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
            
            let index = self.allSlaves.indexOf({ (name, _) -> Bool in
                return name == cell.nameLabel.text!
            })
            
            self.selectedSlaves.append(allSlaves[index!])
            self.navigationItem.rightBarButtonItem?.enabled = true
            
        } else {
            cell.accessoryType = .None
            
            let index = self.selectedSlaves.indexOf({ (name, _) -> Bool in
                return name == cell.nameLabel.text!
            })
            
            self.selectedSlaves.removeAtIndex(index!)
            
            if self.selectedSlaves.count == 0 {
                self.navigationItem.rightBarButtonItem?.enabled = false
            }
        }
    }
}
