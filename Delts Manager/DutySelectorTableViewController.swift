//
//  DutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/18/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ExpandingTableView

class DutySelectorTableViewController: ExpandingTableViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        self.navigationItem.leftBarButtonItem?.tintColor = Constants.Colors.deltsDarkPurple
        self.navigationItem.rightBarButtonItem?.tintColor = Constants.Colors.deltsDarkPurple
        
        loadSampleDuties()
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
    var duties = [Duty]()
    
    
    // MARK: Helper Functions
    func loadSampleDuties() {
        let duty1 = Duty(slave: "", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Completed")
        let duty2 = Duty(slave: "", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Incomplete")
        let duty3 = Duty(slave: "", name: "Kitchen", type: Constants.DutyType.House, date: NSDate(), status: "Pending")
        
        duties += [duty1, duty2, duty3]
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard indexPath.row < duties.count else {
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
        
        
        let identifier = Constants.Identifiers.TableViewCells.ExpandingDutySelectorCell
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! ExpandingDutySelectorCell

        if indexPath.row % 2 == 0 {
            cell.mainContainerView.backgroundColor = Constants.Colors.deltsPurple
        } else {
            cell.mainContainerView.backgroundColor = Constants.Colors.deltsYellow
        }
        
        let duty = duties[indexPath.row]
        
        cell.duty = duty
        cell.titleLabel.text = duty.name
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, duties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}
