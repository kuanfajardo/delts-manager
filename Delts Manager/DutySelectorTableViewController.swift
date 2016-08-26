//
//  DutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/18/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ExpandingTableView
import Alamofire
import Freddy

class DutySelectorTableViewController: UITableViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .Plain, target: self, action: #selector(refreshPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flatWhiteColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flatWhiteColor()
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88
        self.tableView.bounces = false

        loadSampleDutyNames()
        loadSampleHouseDuties()
        
        loadHouseDuties()
    }
    
    func refreshPressed() {
        loadHouseDuties()
        self.tableView.reloadData()
    }
    
    func donePressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Properties:
    var dutyNames = [String]()
    var houseDuties = [HouseDuty]()
    
    // MARK: Helper Functions
    func loadSampleDutyNames() {
        self.dutyNames = ["Pantry One", "Pantry Two", "Kitchen", "Basement", "1st / Foyer", "2nd Big / Trash", "2nd Little / Vacuum", "3rd Big / Trash", "3rd Little / Vacuum", "4th Big / Trash", "4th Little/ Vacuum"]
    }
    
    func loadSampleHouseDuties() {
        let duty1 = HouseDuty(name: "Pantry One", availabilities: [.Unavailable, .Selected,.Open,.Taken,.Taken,.Open, .Unavailable])
        let duty2 = HouseDuty(name: "Pantry Two", availabilities: [.Unavailable, .Taken,.Open,.Taken,.Taken,.Open, .Unavailable])
        let duty3 = HouseDuty(name: "Kitchen", availabilities: [.Unavailable, .Open,.Unavailable,.Taken,.Unavailable,.Open, .Unavailable])
        let duty4 = HouseDuty(name: "Basement", availabilities: [.Unavailable, .Taken,.Unavailable,.Taken,.Unavailable,.Taken, .Unavailable])
        let duty5 = HouseDuty(name: "1st / Foyer", availabilities: [.Unavailable, .Open,.Unavailable,.Open,.Unavailable,.Open, .Unavailable])
        let duty6 = HouseDuty(name: "2nd Little / Vacuum", availabilities: [.Unavailable, .Taken,.Unavailable,.Open,.Unavailable,.Open, .Unavailable])
        
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
        
        let identifier = Constants.Identifiers.TableViewCells.NewDutySelectorCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! DutySelectorCell
        cell.delegate = self
                
        let houseDuty = houseDuties[indexPath.row]
        cell.houseDuty = houseDuty
        cell.titleLabel.text = houseDuty.name

        cell.mondayButton.tag = indexPath.row
        cell.tuesdayButton.tag = indexPath.row
        cell.wednesdayButton.tag = indexPath.row
        cell.thursdayButton.tag = indexPath.row
        cell.fridayButton.tag = indexPath.row
        
        cell.mondayButton.backgroundColor = colorFromAvailability(houseDuty.availabilities[1])
        cell.tuesdayButton.backgroundColor = colorFromAvailability(houseDuty.availabilities[2])
        cell.wednesdayButton.backgroundColor = colorFromAvailability(houseDuty.availabilities[3])
        cell.thursdayButton.backgroundColor = colorFromAvailability(houseDuty.availabilities[4])
        cell.fridayButton.backgroundColor = colorFromAvailability(houseDuty.availabilities[5])
        
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(((7 - houseDuties.count)*2) + houseDuties.count, houseDuties.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func loadHouseDuties() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token
            ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.GetHouseDuties))")
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.GetHouseDuties), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let dutiesJSON = try json.array(0)
                    
                    for duty in dutiesJSON {
                        let dutyID = try duty.int("duty_id")
                        let dayOfWeek = try duty.int("day_of_week")
                        let userName = try duty.string("user_name")
                        let dutyName = try duty.string("duty_name")
                        
                        let availability = self.availabilityFromName(userName)
                        
                        if self.dutyNames.indexOf(dutyName) == nil {
                            self.dutyNames.append(dutyName)
                            let newHouseDuty = HouseDuty(name: dutyName)
                            self.houseDuties.append(newHouseDuty)
                        }
                        
                        self.houseDuties[self.dutyNames.indexOf(dutyName)!].updateForDay(dayOfWeek, withAvailability: availability, takenBy: userName, dutyID: dutyID)
                        
                        
                    }
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in loadHouseDuties")
                }
        }
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
    
    func availabilityFromName(userName: String) -> DutyAvailability{
        switch userName {
        case "Available":
            return DutyAvailability.Open
        case Constants.defaults.stringForKey(Constants.DefaultsKeys.Name)!:
            return DutyAvailability.Selected
        default:
            return DutyAvailability.Taken
        }
    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
}
