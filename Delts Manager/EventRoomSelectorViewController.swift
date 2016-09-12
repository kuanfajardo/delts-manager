//
//  EventRoomSelectorViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 9/11/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventRoomSelectorViewController: UITableViewController {
    // MARK: Properties
    var defaultRooms = ["Basement", "Pantry", "2M", "2F", "Chapter Room", "3F", "3M"]
    
    var selectedRooms = [String]()
    var delegate: PartyPlannerDelegate?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for selectedRoom in selectedRooms {
            if defaultRooms.indexOf(selectedRoom) == nil {
                defaultRooms.append(selectedRoom)
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        self.tableView.bounces = false
        self.tableView.scrollEnabled = false
    }
   
    func donePressed() {
        self.delegate?.passRoomsBack!(selectedRooms)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        guard indexPath.row < defaultRooms.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            cell.userInteractionEnabled = false
            cell.selectionStyle = .None
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsYellow
            }
            
            return cell
        }
        
        
        let identifier = Constants.Identifiers.TableViewCells.EventRoomCell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventRoomTableCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.flatBlackColor()//Constants.Colors.deltsPurple
        } else {
            cell.backgroundColor = UIColor.flatBlackColorDark()//Constants.Colors.deltsYellow
        }
        
        cell.roomLabel.text = defaultRooms[indexPath.row]
        if selectedRooms.indexOf(defaultRooms[indexPath.row]) != nil {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        cell.selectionStyle = .Gray
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(15, defaultRooms.count)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        guard indexPath.row < defaultRooms.count else {
            return
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EventRoomTableCell
        
        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = .Checkmark
            self.selectedRooms.append(cell.roomLabel.text!)
        } else {
            cell.accessoryType = .None
            self.selectedRooms.removeAtIndex(self.selectedRooms.indexOf(cell.roomLabel.text!)!)
        }
    }
}
