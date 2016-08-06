//
//  EventDutyTimeSelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventDutyTimeSelectorTableViewController: UITableViewController {
    // MARK: Properties
    var duties = [String]()
    var times = [String]()
    var indices = [Int]()
    var delegate: PartyPlannerDelegate?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
    }
    
    func donePressed() {
        self.delegate?.passDutyTimesBack!(self.times)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard indexPath.row < self.duties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            cell.userInteractionEnabled = false
            
            return cell
            
        }
        
        let identifier = Constants.Identifiers.TableViewCells.EventDutyTimeCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventDutyTimeSelectorCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        cell.dutyLabel.text = duties[indexPath.row]
        cell.timeSwitch.on = true
        let tag = Int("\(indexPath.section)\(indexPath.row)")!
        self.indices.append(tag)
        cell.timeSwitch.tag = tag
        cell.timeSwitch.onTintColor = Constants.Colors.deltsDarkPurple
        cell.timeSwitch.backgroundColor = Constants.Colors.deltsYellow
        cell.timeSwitch.tintColor = Constants.Colors.deltsDarkPurple
        cell.timeSwitch.layer.cornerRadius = 16
        cell.timeSwitch.addTarget(self, action: #selector(switchFlipped), forControlEvents: .ValueChanged)
        cell.selectionStyle = .None
        
        if self.times[self.duties.indexOf(duties[indexPath.row])!] == "Hour" {
            cell.timeSwitch.on = true
        } else {
            cell.timeSwitch.on = false
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(15,duties.count)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func switchFlipped(sender: UISwitch) {
        switch sender.on {
        case true:
            self.times[self.indices.indexOf(sender.tag)!] = "Hour"
        case false:
            self.times[self.indices.indexOf(sender.tag)!] = "Half Hour"
        }
    }
 
}
