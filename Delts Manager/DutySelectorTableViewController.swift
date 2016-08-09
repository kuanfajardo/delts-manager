//
//  DutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/18/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ExpandingTableView

class DutySelectorTableViewController: UITableViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flatWhiteColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flatWhiteColor()
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88
        self.tableView.bounces = false

        loadSampleDuties()
        loadSampleDutyNames()
        loadSampleHouseDuties()
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
    var dutyNames = [String]()
    var houseDuties = [HouseDuty]()
    
    // MARK: Helper Functions
    func loadSampleDuties() {
        let duty1 = Duty(slave: "", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: .Complete)
        let duty2 = Duty(slave: "", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: .Pending)
        let duty3 = Duty(slave: "", name: "Kitchen", type: Constants.DutyType.House, date: NSDate(), status: .Punted)
        
        duties += [duty1, duty2, duty3]
    }
    
    func loadSampleDutyNames() {
        self.dutyNames = ["Pantry One", "Pantry Two", "Kitchen", "Basement", "1st / Foyer", "2nd Big / Trash", "2nd Little / Vacuum", "3rd Big / Trash", "3rd Little / Vacuum", "4th Big / Trash", "4th Little/ Vacuum"]
    }
    
    func loadSampleHouseDuties() {
        let duty1 = HouseDuty(name: "Pantry One", days: [.Open,.Open,.Taken,.Taken,.Open])
        let duty2 = HouseDuty(name: "Pantry Two", days: [.Taken,.Open,.Taken,.Taken,.Open])
        let duty3 = HouseDuty(name: "Kitchen", days: [.Open,.Unavailable,.Taken,.Unavailable,.Open])
        let duty4 = HouseDuty(name: "Basement", days: [.Taken,.Unavailable,.Taken,.Unavailable,.Taken])
        let duty5 = HouseDuty(name: "1st / Foyer", days: [.Open,.Unavailable,.Open,.Unavailable,.Open])
        let duty6 = HouseDuty(name: "2nd Little / Vacuum", days: [.Taken,.Unavailable,.Open,.Unavailable,.Open])
        
        self.houseDuties += [duty1, duty2, duty3, duty4, duty5, duty6]
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard indexPath.row < houseDuties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 1 {
                cell.backgroundColor = Constants.Colors.deltsYellow//UIColor.flatMagentaColor()//Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        //let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! ExpandingDutySelectorCell
        let identifier = Constants.Identifiers.TableViewCells.NewDutySelectorCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutySelectorCell
        /*
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = Constants.Colors.deltsYellow//UIColor.flatMagentaColor()//Constants.Colors.deltsPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }*/
        
        /*let duty = duties[indexPath.row]
        
        cell.duty = duty
        cell.titleLabel.text = duty.name*/
        
        let houseDuty = houseDuties[indexPath.row]
        cell.houseDuty = houseDuty
        cell.titleLabel.text = houseDuty.name

        cell.mondayButton.tag = indexPath.row
        cell.tuesdayButton.tag = indexPath.row
        cell.wednesdayButton.tag = indexPath.row
        cell.thursdayButton.tag = indexPath.row
        cell.fridayButton.tag = indexPath.row
        
        cell.mondayButton.backgroundColor = colorFromAvailability(houseDuty.days[0])
        cell.tuesdayButton.backgroundColor = colorFromAvailability(houseDuty.days[1])
        cell.wednesdayButton.backgroundColor = colorFromAvailability(houseDuty.days[2])
        cell.thursdayButton.backgroundColor = colorFromAvailability(houseDuty.days[3])
        cell.fridayButton.backgroundColor = colorFromAvailability(houseDuty.days[4])
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(((7 - houseDuties.count)*2) + houseDuties.count, houseDuties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Helper
    func colorFromAvailability(availability: DutyAvailability) -> UIColor {
        switch availability {
        case .Open:
            return UIColor.flatWhiteColor()
        case .Selected:
            return UIColor.flatGreenColor()
        case .Taken:
            return UIColor.flatWatermelonColor()
        case .Unavailable:
            return UIColor.flatGrayColorDark()
        }
    }
}
