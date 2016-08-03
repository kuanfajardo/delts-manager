//
//  PartyDetailViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/25/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PartyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    // MARK: Properties
    var event: Event?
    var segControl: UISegmentedControl?
    var segment: String {
        return (self.segControl!.titleForSegmentAtIndex((self.segControl?.selectedSegmentIndex)!))!
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segControl = UISegmentedControl(items: ["Invites", "Duties"])
        self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
        self.segControl!.tintColor = Constants.Colors.deltsDarkPurple
        self.segControl!.selectedSegmentIndex = 0
        self.navigationItem.titleView = self.segControl
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        reloadViews()
    }
    
    func reloadViews() {
        switch self.segment {
        case "Duties":
            let tableView = UITableView()
            tableView.delegate = self
            self.view = tableView
        case "Invites": break
            //
        default:
            return
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = Constants.Identifiers.TableViewCells.PartyTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PartyTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        guard indexPath.row < event!.duties.count else {
            cell.partyLabel.text = ""
            cell.dateLabel.text = ""
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        cell.event = event
        cell.partyLabel.text = event!.name
        cell.dateLabel.text = event!.startTimeString
        //cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, (event?.duties.count)!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    // MARK: - Navigation
    
    
    // Go to detail event view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! PartyDetailViewController
        let cell = sender as! PartyTableViewCell
        
        controller.event = cell.event
    }

}
