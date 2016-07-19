//
//  DutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/18/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class DutySelectorTableViewController: UITableViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleDuties()
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
        guard indexPath.row < duties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsLightPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            return cell
        }
        
        
        let identifier = Constants.Identifiers.TableViewCells.DutySelectorCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutySelectorTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        let duty = duties[indexPath.row]
        
        cell.duty = duty
        cell.titleLabel.text = duty.name
        cell.mondayButton.imageView?.image = UIImage(named: Constants.Photos.BlackCircle)
        cell.tuesdayButton.imageView?.image = UIImage(named: Constants.Photos.BlackCircle)
        cell.wednesdayButton.imageView?.image = UIImage(named: Constants.Photos.BlackCircle)
        cell.thursdayButton.imageView?.image = UIImage(named: Constants.Photos.BlackCircle)
        cell.fridayButton.imageView?.image = UIImage(named: Constants.Photos.BlackCircle)
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
