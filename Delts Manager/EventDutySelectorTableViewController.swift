//
//  EventDutySelectorTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventDutySelectorTableViewController: UITableViewController, UITextFieldDelegate {
    // MARK: Properties
    var defaultDuties = ["Outer Door", "Inner Door", "Check-In", "2nd Floor Back Stairs", "3rd Floor Back Stairs", "2nd-1st Landing", "2nd-3rd Landing", "VIP", "Bar", "2F Bar", "2M Bar", "Basement Bar", "DJ"]
    
    var customDuties = [String]()
    var selectedDuties = [String]()
    var delegate: PartyPlannerDelegate?
    var isKeyboardShowing = false


    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        for selectedDuty in selectedDuties {
            if defaultDuties.indexOf(selectedDuty) == nil {
                defaultDuties.append(selectedDuty)
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidShow), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardDidShow() {
        self.isKeyboardShowing = true
    }
    
    func keyboardDidHide() {
        self.isKeyboardShowing = false
    }
    
    func donePressed() {
        self.delegate?.passDutiesBack!(selectedDuties)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        guard indexPath.row < defaultDuties.count else {
            guard indexPath.row < defaultDuties.count + customDuties.count else {
                let identifier = Constants.Identifiers.TableViewCells.AddCustomDutyCell
                let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
                
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsPurple
                } else {
                    cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsYellow
                }
                
                return cell
            }
            
            let identifier = Constants.Identifiers.TableViewCells.CustomEventDutyCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! CustomEventDutyTableCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsYellow
            }
            
            let index = indexPath.row - defaultDuties.count
            /*if index <= 0 {
                cell.accessoryType = .None
            } else if selectedDuties.indexOf(customDuties[indexPath.row - defaultDuties.count]) != nil {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }*/
            cell.accessoryType = .Checkmark
            
            cell.selectionStyle = .Gray
            cell.tag = index
            cell.dutyTextField.delegate = self
            cell.dutyTextField.tag = index
            cell.dutyTextField.becomeFirstResponder()
            return cell

            
        }
        
        
        let identifier = Constants.Identifiers.TableViewCells.EventDutyCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventDutyTableCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsPurple
        } else {
            cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsYellow
        }
        
        cell.dutyName.text = defaultDuties[indexPath.row]
        if selectedDuties.indexOf(defaultDuties[indexPath.row]) != nil {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultDuties.count + customDuties.count + 1
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        guard isKeyboardShowing == false else {
            return
        }
        
        guard indexPath.row < defaultDuties.count else {
            guard indexPath.row < defaultDuties.count + customDuties.count else {
                addCustomDuty()
                return
            }
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomEventDutyTableCell
            
            if cell.accessoryType == UITableViewCellAccessoryType.None {
                cell.accessoryType = .Checkmark
                self.selectedDuties.append(cell.dutyTextField.text!)
            } else {
                cell.accessoryType = .None
                self.selectedDuties.removeAtIndex(self.selectedDuties.indexOf(cell.dutyTextField.text!)!)
            }
            
            return
            
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EventDutyTableCell

        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = .Checkmark
            self.selectedDuties.append(cell.dutyName.text!)
        } else {
            cell.accessoryType = .None
            self.selectedDuties.removeAtIndex(self.selectedDuties.indexOf(cell.dutyName.text!)!)
        }
    }
    
    func addCustomDuty() {
        customDuties.append("")
        self.tableView.reloadData()
    }
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 {
            textField.resignFirstResponder()
            self.selectedDuties.append(textField.text!)
            textField.userInteractionEnabled = false
            //self.tableView.userInteractionEnabled = true
            return true
        } else {
            textField.resignFirstResponder()
            return true
        }
        
    }
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        self.tableView.userInteractionEnabled = false
    }*/
    
}
