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
        
        let duty = duties[indexPath.row]
        
        cell.dutyLabel.text = duty.name
        cell.statusLabel.text = duty.status
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        cell.dateLabel.text = dateFormatter.stringFromDate(duty.date)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duties.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
