//
//  EventDutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventDutySelectorTableViewController: UITableViewController {
    // MARK: Properties
    var duties = ["Outer Door", "Inner Door", "Check-In", "2nd Floor Back Stairs", "3rd Floor Back Stairs", "2nd-1st Landing", "2nd-3rd Landing", "VIP", "Bar", "2F Bar", "2M Bar", "Basement Bar", "DJ"]

    
    var selected = [String]()
    var delegate: PartyPlannerDelegate?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
    }
    
    func donePressed() {
        self.delegate?.passDutiesBack!(selected)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let identifier = Constants.Identifiers.TableViewCells.EventDutyCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventDutyTableCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        cell.dutyName.text = duties[indexPath.row]
        if selected.indexOf(duties[indexPath.row]) != nil {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        cell.selectionStyle = .Gray
        cell.accessoryView?.backgroundColor = Constants.Colors.deltsYellow
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duties.count
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EventDutyTableCell

        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = .Checkmark
            self.selected.append(cell.dutyName.text!)
        } else {
            cell.accessoryType = .None
            self.selected.removeAtIndex(self.selected.indexOf(cell.dutyName.text!)!)
        }
    }
}
