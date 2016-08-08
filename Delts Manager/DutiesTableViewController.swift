//
//  DutiesTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import ChameleonFramework

class DutiesTableViewController: UITableViewController, MGSwipeTableCellDelegate {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.Checker) || Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
            self.segControl = UISegmentedControl(items: [Segment.User, Segment.Checker])
            
            if Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
                self.segControl!.insertSegmentWithTitle(Segment.Admin, atIndex: 2, animated: false)
            }
            
            self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
            self.segControl!.tintColor = UIColor.whiteColor()//Constants.Colors.deltsDarkPurple
            self.segControl!.selectedSegmentIndex = 0

            
            self.navigationItem.titleView = self.segControl
        }
        
        // loadUserDuties()
        loadSampleDuties()
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        // Reload correct set of duties
        switch self.segment {
        case Segment.User:
            loadUserDuties()
            break
        case Segment.Checker:
            loadCheckerDuties()
            break
        case Segment.Admin:
            loadAdminDuties()
        default:
            loadSampleDuties()
        }
        
        // Reload data onto table view
        self.tableView.reloadData()
    }
    
    // MARK: Properties:
    var duties = [Duty]()
    
    func loadSampleDuties() {
        let duty1 = Duty(slave: "Juan", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Completed")
        let duty2 = Duty(slave: "Juan", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: "Incomplete")
        let duty3 = Duty(slave: "Juan", name: "Kitchen", type: Constants.DutyType.House, date: NSDate(), status: "Pending")
        
        duties += [duty1, duty2, duty3]
    }
    
    var segControl: UISegmentedControl?
    var segment: String {
        if self.segControl == nil {
            return Segment.User
        } else {
            return (self.segControl!.titleForSegmentAtIndex((self.segControl?.selectedSegmentIndex)!))!
        }
    }
    
    struct Segment {
        static let User = "User"
        static let Checker = "Checker"
        static let Admin = "Admin"
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if duties.count == 0 && indexPath.row == 1 {
            let identifier = Constants.Identifiers.TableViewCells.NoDutiesCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            cell.backgroundColor = Constants.Colors.deltsYellow
            
            return cell
        }
        
        guard indexPath.row < duties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        if self.segment == Segment.Checker || self.segment == Segment.Admin {
            let identifier = Constants.Identifiers.TableViewCells.DutyCheckoffCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutyCheckoffTableViewCell

            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsYellow
            } else {
                cell.dutyLabel.textColor = UIColor.whiteColor()
                cell.dateLabel.textColor = UIColor.whiteColor()
                cell.slaveLabel.textColor = UIColor.whiteColor()
            }

            // right buttons
            let checkButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.flatWatermelonColor())
            cell.rightButtons = [checkButton]
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.delegate = self
            
            let duty = duties[indexPath.row]
            cell.duty = duty
            cell.dutyLabel.text = duty.name
            cell.dateLabel.text = duty.dateString
            cell.slaveLabel.text = duty.slave
            // TODO: Real
            cell.statusImageView?.image = Constants.Photos.BlackCircle
            cell.selectionStyle = .Gray
            return cell

        } else {
            let identifier = Constants.Identifiers.TableViewCells.DutyTableViewCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutiesTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsYellow
            } else {
                cell.dutyLabel.textColor = UIColor.whiteColor()
                cell.dateLabel.textColor = UIColor.whiteColor()
            }
                        
            // right buttons
            let checkButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.flatWatermelonColor())
            cell.rightButtons = [checkButton]
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.delegate = self
            
            let duty = duties[indexPath.row]
            
            cell.duty = duty
            cell.dutyLabel.text = duty.name
            cell.dateLabel.text = duty.dateString
            // TODO: Real
            cell.statusImageView?.image = Constants.Photos.BlackCircle
            cell.selectionStyle = .Gray
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(15, duties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // Go to detail duty view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.Identifiers.Segues.UserDutyDetailSegue:
            let cell = sender as! DutiesTableViewCell
            let controller = segue.destinationViewController as! DutyDetailViewController
            controller.duty = cell.duty
            controller.role = 0
            
            break
        case Constants.Identifiers.Segues.CheckerDutyDetailSegue:
            let cell = sender as! DutyCheckoffTableViewCell
            let controller = segue.destinationViewController as! DutyDetailViewController
            controller.duty = cell.duty
            
        default: break
        }
        
        
    }
    
    // MARK: Duty Loading
    func loadUserDuties() {
        //
    }
    
    func loadCheckerDuties() {
        //
    }
    
    func loadAdminDuties() {
        //
    }
    
    // MGSwipeTableCellDelegate
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch self.segment {
        case Segment.User:
            print("User request checkoff")
            userRequestCheckoff()
            break
        case Segment.Admin, Segment.Checker:
            print("Checker/Admin grant checkoff")
            adminGrantCheckoff()
        default:
            break
        }
        return true
    }
    
    // Actions
    func userRequestCheckoff() {
        //
    }
    
    func adminGrantCheckoff() {
        //
    }

}
