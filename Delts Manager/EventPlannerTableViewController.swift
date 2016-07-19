//
//  EventPlannerTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/19/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventPlannerTableViewController: UITableViewController {
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
    }
    
    func cancelPressed() {
        // TODO: Add functionality
        print("cancel pressed")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        // TODO: Add functionality
        print("done pressed")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Properties:
    var properties = ["Event Name",
                      "Start Time",
                      "End Time",
                      "Duties"]
    
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard indexPath.row < properties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsLightPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            return cell
        }
        
        
        let identifier = Constants.Identifiers.TableViewCells.EventPropertyCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventPropertyTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        cell.nameLabel.text = properties[indexPath.row]
        cell.descriptionLabel.text = "Description"
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, properties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            editName()
        case 1:
            editStartTime()
        case 2:
            editEndTime()
        case 3:
            editDuties()
        default:
            return
        }
    }

    func editName() {
        print("Edit Name")
    }
    
    func editStartTime() {
        print("Edit ST")
    }
    
    func editEndTime() {
        print("Edit ET")
    }
    
    func editDuties() {
        print("Edit Duties")
    }
}
