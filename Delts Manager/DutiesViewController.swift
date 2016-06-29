//
//  DutiesViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/28/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class DutiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Outlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "DutyTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutiesTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red:1.0, green:0.87004060520000004, blue:0.50798801100000002, alpha:0.5)
        } else {
            cell.backgroundColor = UIColor(red: 1.0, green: 0.87004060520000004, blue: 0.50798801100000002, alpha: 1.0)
        }

        guard indexPath.row < duties.count else {
            cell.dutyLabel.text = ""
            cell.dateLabel.text = ""
            cell.statusLabel.text = ""
            cell.statusImageView?.image = nil
            
            return cell
        }
        
        let duty = duties[indexPath.row]
        
        cell.dutyLabel.text = duty.name
        cell.statusLabel.text = ""
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MM/dd"
        cell.dateLabel.text = dateFormatter.stringFromDate(duty.date)
        cell.statusImageView?.image = UIImage(named: "first")

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
