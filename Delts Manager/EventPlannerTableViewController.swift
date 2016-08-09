//
//  EventPlannerTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/19/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import DatePickerCell

class EventPlannerTableViewController: UITableViewController, PartyPlannerDelegate {
    // MARK: Properties
    var sectionTitles = [
        0 : "Info",
        1 : "Times",
        2 : "Duties",
        3 : "Duty Time Slots",
        4 : ""
    ]
    
    var data: [String : [(String, String)]] = [:]
    
    var eventName = "None"
    var startTime: NSDate?
    var startTimeString: String? {
        if let date = startTime {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MM/dd, hh:mm"
            return dateFormatter.stringFromDate(date)
        }
        
        return nil
    }
    var endTime: NSDate?
    var endTimeString: String? {
        if let date = endTime {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MM/dd, hh:mm"
            return dateFormatter.stringFromDate(date)
        }
        
        return nil
    }
    var duties = [String]()
    var times = [String]()
    var delegate: PartyPlannerExtendedDelegate?
    
    var isNameSet = false
    var isStartTimeSet = false
    var isEndTimeSet = false
    var isDutiesSet = false
    var isTimesSet = false
    
    var startTimeTableCell = DatePickerCell(style: .Default, reuseIdentifier: nil)
    var endTimeTableCell = DatePickerCell(style: .Default, reuseIdentifier: nil)
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
        
        self.tableView.scrollEnabled = true
        self.tableView.bounces = false
        
        self.startTimeTableCell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsPurple
        self.startTimeTableCell.rightLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
        self.startTimeTableCell.leftLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
        self.startTimeTableCell.rightLabelTextColor = UIColor.flatWhiteColor()
        self.startTimeTableCell.tintColor = UIColor.flatWhiteColor()
        self.startTimeTableCell.leftLabel.textColor = UIColor.flatWhiteColor()
        self.startTimeTableCell.leftLabel.text = "Start Time"
        self.startTimeTableCell.datePicker.minuteInterval = 30
        
        self.endTimeTableCell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsPurple
        self.endTimeTableCell.rightLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
        self.endTimeTableCell.leftLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
        self.endTimeTableCell.rightLabelTextColor = UIColor.flatWhiteColor()
        self.endTimeTableCell.tintColor = UIColor.flatWhiteColor()
        self.endTimeTableCell.leftLabel.textColor = UIColor.flatWhiteColor()
        self.endTimeTableCell.leftLabel.text = "End Time"
        self.endTimeTableCell.datePicker.minuteInterval = 30
        
        reloadData()
    }
    
    func reloadData() {
        self.data = [
            "Info" : [
                ("Event Name", "\(self.eventName)")
            ],
            "Times" : [
                ("Start Time", "\(self.startTimeString ?? "None")"),
                ("End Time", "\(self.endTimeString ?? "None")")
            ],
            "Duties" : [
                ("Select Duties", "\("\(self.duties.count)" ?? "No") Duties Selected")
            ],
            "Duty Time Slots" : [
                ("Select Duty Times", "\("\(self.duties.count)" ?? "No") Duties Selected")],
            "" : []
        ]
        
        if isNameSet && isStartTimeSet && isEndTimeSet && isDutiesSet && isTimesSet {
            self.navigationItem.rightBarButtonItem!.enabled = true
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let propertyData = data[sectionTitles[indexPath.section]!]![indexPath.row]
        let propertyName = propertyData.0
        let propertyDescription = propertyData.1
        
        guard indexPath.section != 1 else {
            /*let cell = DatePickerCell(style: .Default, reuseIdentifier: "Plain")
            cell.backgroundColor = Constants.Colors.deltsPurple
            cell.rightLabelTextColor = UIColor.blackColor()
            cell.rightLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
            cell.leftLabel.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
            cell.leftLabel.text = propertyName
            cell.tintColor = UIColor.blackColor()
 
            return cell*/
            switch indexPath.row {
            case 0:
                return self.startTimeTableCell
            case 1:
                return self.endTimeTableCell
            default:
                return UITableViewCell()
            }
        }
        
        let identifier = Constants.Identifiers.TableViewCells.EventPropertyCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventPropertyTableViewCell
        
        cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsPurple
        
        cell.nameLabel.text = propertyName
        cell.descriptionLabel.text = propertyDescription
        cell.descriptionLabel.textColor = UIColor.flatWhiteColor()
        cell.nameLabel.textColor = UIColor.flatWhiteColor()
        cell.selectionStyle = .Gray
        cell.accessoryType = .None
        cell.accessoryView?.backgroundColor = Constants.Colors.deltsPurple
        
        if indexPath.section == 3 && self.duties.count <= 0 {
            cell.userInteractionEnabled = false
        } else {
            cell.userInteractionEnabled = true
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[sectionTitles[section]!]!.count
            
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(35)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 {
            return CGFloat(400)
        }
        
        return CGFloat(0)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard indexPath.section != 1 else {
            let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! DatePickerCell
            return cell.datePickerHeight()
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
    }
   
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsYellow
        header.textLabel?.font = UIFont(name: Constants.Fonts.systemLight, size: CGFloat(17))
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        footer.contentView.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsYellow
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            editName()
        case 1:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! DatePickerCell
            cell.selectedInTableView(tableView)
            validateTimes()
            /*if indexPath.row == 0 {
                editStartTime()
            } else {
                editEndTime()
            }*/
            break
        case 2:
            editDuties()
        case 3:
            editDutyTimes()
        default:
            return
        }
    }
    
    
    // MARK: Actions
    // User Defined
    func cancelPressed() {
        // TODO: Add functionality
        print("cancel pressed")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        // TODO: Add functionality
        print("done pressed")
        let event = Event(name: self.eventName, startTime: self.startTime!, endTime: self.endTime!, duties: makeDuties(), times: self.times)
        self.delegate?.passEventBack(event)
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    // MARK: Helper Functions
    func editName() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.EventNameController) as! EventNameViewController

        controller.delegate = self
        if self.eventName != "None" {
            controller.placeholderText = self.eventName
        }

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editStartTime() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.StartTimeController) as! EventStartTimeViewController
        
        controller.delegate = self

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editEndTime() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.EndTimeController) as! EventEndTimeViewController
        
        controller.delegate = self

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editDuties() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.DutyChooserController) as! EventDutySelectorTableViewController
        
        controller.delegate = self
        controller.selectedDuties = self.duties

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editDutyTimes() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.DutyTimeChooserController) as! EventDutyTimeSelectorTableViewController
        
        controller.delegate = self
        controller.duties = self.duties
        controller.times = self.times
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func validateTimes() {
        guard self.startTimeTableCell.date.compare(NSDate()).rawValue == 1 else {
            return
        }
        
        guard self.startTimeTableCell.date.compare(self.endTimeTableCell.date).rawValue == -1 else {
            return
        }
        
        self.startTime = self.startTimeTableCell.date
        self.endTime = self.endTimeTableCell.date
        
        self.isStartTimeSet = true
        self.isEndTimeSet = true
        
        reloadData()
    }
    
    // MARK: Party Planner Delegate
    func passDutiesBack(value: [String]) {
        self.duties = value
        self.times = [String](count: self.duties.count, repeatedValue: "Hour")
        if value.count > 0 {
            self.isDutiesSet = true
        }
        reloadData()
        self.tableView.reloadData()
    }
    
    func passNameBack(value: String) {
        self.eventName = value
        self.isNameSet = true
        reloadData()
        self.tableView.reloadData()
    }
    
    func passStartTimeBack(value: NSDate) {
        self.startTime = value
        self.isStartTimeSet = true
        reloadData()
        self.tableView.reloadData()
    }
    
    func passEndTimeBack(value: NSDate) {
        self.endTime = value
        self.isEndTimeSet = true
        reloadData()
        self.tableView.reloadData()
    }
    
    func passDutyTimesBack(value: [String]) {
        self.times = value
        self.isTimesSet = true
        reloadData()
        self.tableView.reloadData()
    }
    
    func makeDuties() -> [Duty] {
        let seconds = self.endTime!.timeIntervalSinceDate(self.startTime!)
        let numHalfSlots = Int(ceil(seconds / (60 * 30)))
        let numHourSlots = Int(ceil(seconds / (60 * 60)))
        var allDuties = [Duty]()
        
        for i in 0..<self.duties.count {
            let dutyName = self.duties[i]
            let dutyTime = self.times[i]
            var durationMin: Int
            var durationSec: Double
            
            var numSlots: Int
            if dutyTime == "Half Hour" {
                numSlots = numHalfSlots
                durationMin = 30
                durationSec = 30 * 60
            } else {
                numSlots = numHourSlots
                durationMin = 60
                durationSec = 60 * 60
            }
            
            for _ in 0..<numSlots {
                let date = self.startTime?.dateByAddingTimeInterval(NSTimeInterval(durationSec))
                let duty = Duty(slave: "", name: dutyName, type: .Party, status: .Incomplete, startTime: date!, duration: durationMin)
                allDuties.append(duty)
            }
        }

        return allDuties
    }
}
