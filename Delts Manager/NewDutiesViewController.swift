//
//  NewDutiesViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class NewDutiesViewController: UITableViewController {

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
        let identifier = "NewDutyTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! NewDutiesTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        guard indexPath.row < duties.count else {
            cell.dutyLabel.text = ""
            cell.dateLabel.text = ""
            cell.statusImageView?.image = nil
            
            return cell
        }
        
        let duty = duties[indexPath.row]
        
        cell.dutyLabel.text = duty.name
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MM/dd"
        cell.dateLabel.text = dateFormatter.stringFromDate(duty.date)
        cell.statusImageView?.image = UIImage(named: "first")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, duties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
