//
//  DutiesTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class DutiesTableViewController: UITableViewController {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.Checker) || Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
            let segControl = UISegmentedControl(items: ["User", "Checker"])
            
            if Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
                segControl.insertSegmentWithTitle("Admin", atIndex: 2, animated: false)
            }
            
            segControl.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
            segControl.tintColor = Constants.Colors.deltsDarkPurple
            segControl.selectedSegmentIndex = 0

            
            self.navigationItem.titleView = segControl
        }
        
        // loadDuties()
        loadSampleDuties()
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    // MARK: Properties:
    var duties = [Duty]()
    
    func loadSampleDuties() {
        let duty1 = Duty(name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Completed")
        let duty2 = Duty(name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Incomplete")
        let duty3 = Duty(name: "Kitchen", type: Constants.DutyType.House, date: NSDate(), status: "Pending")
        
        duties += [duty1, duty2, duty3]
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = Constants.Identifiers.TableViewCells.DutyTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutiesTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        guard indexPath.row < duties.count else {
            cell.dutyLabel.text = ""
            cell.dateLabel.text = ""
            cell.statusImageView?.image = nil
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        let duty = duties[indexPath.row]
        
        cell.duty = duty
        cell.dutyLabel.text = duty.name
        cell.dateLabel.text = duty.dateString
        // TODO: Real
        cell.statusImageView?.image = UIImage(named: Constants.Photos.BlackCircle)
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, duties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    
    // MARK: - Navigation

    // Go to detail duty view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! DutyDetailViewController
        let cell = sender as! DutiesTableViewCell
 
        controller.duty = cell.duty
    }

}
