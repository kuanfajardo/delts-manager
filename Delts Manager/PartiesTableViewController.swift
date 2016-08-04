//
//  PartiesTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PartiesTableViewController: UITableViewController, PartyPlannerDelegate {
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.BouncingChair) || Constants.userAuthorized(Constants.Roles.Admin) {
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addPressed))
            rightAddButton.tintColor = Constants.Colors.deltsDarkPurple
            
            self.navigationItem.rightBarButtonItem = rightAddButton
        }
        
        // loadEvents()
        loadSampleEvents()
    }
    
    func addPressed() {
        let identifier = Constants.Identifiers.Controllers.NewPartyController
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! EventPlannerTableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // MARK: Properties:
    var events = [Event]()
    
    func loadSampleEvents() {
        let event1 = Event(name: "Deltona Beach", startTime: NSDate(), endTime: NSDate().dateByAddingTimeInterval(NSTimeInterval(1000)), duties: [], times: [])
        let event2 = Event(name: "St. Patty's Day", startTime: NSDate(), endTime: NSDate().dateByAddingTimeInterval(NSTimeInterval(1000)), duties: [], times: [])
        let event3 = Event(name: "Around le World", startTime: NSDate(), endTime: NSDate().dateByAddingTimeInterval(NSTimeInterval(1000)), duties: [], times: [])

        self.events += [event1, event2, event3]
    }
    
    
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if events.count == 0 && indexPath.row == 1 {
            let identifier = Constants.Identifiers.TableViewCells.NoEventsCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            cell.backgroundColor = Constants.Colors.deltsYellow
            
            return cell
        }
        
        let identifier = Constants.Identifiers.TableViewCells.PartyTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PartyTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        guard indexPath.row < events.count else {
            cell.partyLabel.text = ""
            cell.dateLabel.text = ""
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        let event = events[indexPath.row]
        
        cell.event = event
        cell.partyLabel.text = event.name
        cell.dateLabel.text = event.startTimeString
        //cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .Gray
        cell.userInteractionEnabled = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, events.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Navigation
    
    
    // Go to detail event view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! PartyDetailTableViewController
        let cell = sender as! PartyTableViewCell
        
        controller.event = cell.event
    }
    
    // MARK: Load Events
    func loadEvents() {
        //
    }

}
