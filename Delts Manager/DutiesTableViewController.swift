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
import Alamofire
import Freddy

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
        let duty1 = Duty(slave: "Juan", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: DutyStatus.Complete)
        let duty2 = Duty(slave: "Juan", name: "Pantry", type: Constants.DutyType.House, date: NSDate(), status: DutyStatus.Pending)
        let duty3 = Duty(slave: "Juan", name: "Kitchen", type: Constants.DutyType.House, date: NSDate(), status: DutyStatus.Punted)
        let duty4 = Duty(slave: "Juan", name: "2nd Little / Vacuum", type: .House, date: NSDate(), status: .Incomplete)
        
        duties += [duty1, duty2, duty3, duty4]
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
            
            return cell
        }
        
        guard indexPath.row < duties.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatPurpleColor()
            }
            
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        if self.segment == Segment.Checker || self.segment == Segment.Admin {
            let identifier = Constants.Identifiers.TableViewCells.DutyCheckoffCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutyCheckoffTableViewCell

            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatPurpleColor()
            }
            
            cell.dutyLabel.textColor = UIColor.whiteColor()
            cell.dateLabel.textColor = UIColor.whiteColor()
            cell.slaveLabel.textColor = UIColor.whiteColor()

            let duty = duties[indexPath.row]

            // right buttons
            cell.rightButtons = buttonsFromStatus(duty.status)
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.rightExpansion.fillOnTrigger = true
            cell.rightExpansion.buttonIndex = 0
            cell.delegate = self
            
            cell.duty = duty
            cell.dutyLabel.text = duty.name
            cell.dateLabel.text = duty.dateString
            cell.slaveLabel.text = duty.slave
            cell.statusImageView?.image = imageFromStatus(duty.status)
            cell.selectionStyle = .Gray
            
            return cell

        } else {
            let identifier = Constants.Identifiers.TableViewCells.DutyTableViewCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutiesTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatPurpleColor()
            }
            
            cell.dutyLabel.textColor = UIColor.whiteColor()
            cell.dateLabel.textColor = UIColor.whiteColor()
            
            let duty = duties[indexPath.row]

            
            // right buttons
            cell.rightButtons = buttonsFromStatus(duty.status)
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.rightExpansion.fillOnTrigger = true
            cell.rightExpansion.buttonIndex = 0
            cell.delegate = self
            
            
            cell.duty = duty
            cell.dutyLabel.text = duty.name
            cell.dateLabel.text = duty.dateString
            cell.statusImageView?.image = imageFromStatus(duty.status)
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
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token
        ]
        
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.AccountDuties), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    print("Error")
                }
        }
    }
    
    func loadCheckerDuties() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token
        ]
        
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.ManagerRequestedCheckoffs), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    print("Error")
                }
        }

    }
    
    func loadAdminDuties() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token
        ]
        
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.ManagerAllDuties), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    print("Error")
                }
        }

    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
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
    
    // MARK: Helper
    func imageFromStatus(status: DutyStatus) -> UIImage {
        switch status {
        case .Complete:
            return Constants.Photos.GreenCheck
        case .Incomplete:
            return Constants.Photos.WhiteAttention
        case .Pending:
            return Constants.Photos.Clock
        case .Punted:
            return Constants.Photos.Cancel
        }
    }
    
    func buttonsFromStatus(status: DutyStatus) -> [MGSwipeButton] {
        let requestCheckoffButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.flatGreenColor())
        let grantCheckoffButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.flatGreenColor())
        
        let noButtons = [MGSwipeButton]()
        
        switch self.segment {
        case Segment.User:
            switch status {
            case .Complete:
                return noButtons
            case .Incomplete:
                return [requestCheckoffButton]
            case .Pending:
                return noButtons
            case .Punted:
                return noButtons
            }
        case Segment.Checker, Segment.Admin:
            switch status {
            case .Complete:
                return noButtons
            case .Incomplete:
                return noButtons
            case .Pending:
                return [grantCheckoffButton]
            case .Punted:
                return noButtons
            }
        default:
            return noButtons
        }
    }

}
