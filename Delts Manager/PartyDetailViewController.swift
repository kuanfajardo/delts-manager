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
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segItem = UISegmentedControl(items: ["Invites", "Duties"])
        segItem.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
        segItem.tintColor = Constants.Colors.deltsDarkPurple
        segItem.selectedSegmentIndex = 0
        self.navigationItem.titleView = segItem
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        let segItem = self.navigationItem.titleView as! UISegmentedControl
        reloadViews(segItem.titleForSegmentAtIndex(segItem.selectedSegmentIndex)!)
    }
    
    func reloadViews(tab: String) {
        switch tab {
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
