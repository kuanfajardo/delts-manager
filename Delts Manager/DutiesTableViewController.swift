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
        loadSampleDuties()
    }
    
    // MARK: Properties:
    var duties = [Duty]()
    
    func loadSampleDuties() {
        let duty1 = Duty(name: "Pantry", date: NSDate(), status: "Completed")
        let duty2 = Duty(name: "Pantry", date: NSDate(), status: "Incomplete")
        let duty3 = Duty(name: "Kitchen", date: NSDate(), status: "Pending")
        
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
        cell.statusImageView?.image = UIImage(named: "first")
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
