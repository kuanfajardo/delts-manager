//
//  PuntsTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PuntsTableViewController: UITableViewController, MGSwipeTableCellDelegate {
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.HonorBoard) || Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
            self.segControl = UISegmentedControl(items: ["User", "Admin"/*, "Makeups"*/])
            
            self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
            self.segControl!.tintColor = Constants.Colors.deltsDarkPurple
            self.segControl!.selectedSegmentIndex = 0
            
            self.navigationItem.titleView = self.segControl
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addPressed))
            rightAddButton.tintColor = Constants.Colors.deltsDarkPurple
            
            self.navigationItem.rightBarButtonItem = rightAddButton

        }
        
        //loadPunts()
        loadSamplePunts()
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        // Reload correct set of punts
        switch self.segment {
        case "User":
            loadUserPunts()
            break
        case "Admin":
            loadAdminPunts()
            break
        default:
            loadSamplePunts()
        }
        
        // Reload table view
        self.tableView.reloadData()
    }
    
    
    func addPressed() {
        let alertController = UIAlertController(title: "Add...", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("Cancel")
        }
        alertController.addAction(cancelAction)
        
        let puntAction = UIAlertAction(title: "New Punt", style: .Default) { (action) in
            print("New Personal Punt")
        }
        alertController.addAction(puntAction)
        
        let massPuntAction = UIAlertAction(title: "New Mass Punt", style: .Default) { (action) in
            print("New Mass Punt")
        }
        alertController.addAction(massPuntAction)
        
        let puntMakeupAction = UIAlertAction(title: "New Punt Makeup", style: .Default) { (action) in
            print("New Punt Makeup")
        }
        //alertController.addAction(puntMakeupAction)
        
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Properties:
    var punts = [Punt]()
    
    func loadSamplePunts() {
        let punt1 = Punt(slave: "Juan", name: "Pantry", date: NSDate(), givenBy: "Erick Friis", status: "Completed")
        let punt2 = Punt(slave: "Juan", name: "Pantry", date: NSDate(), givenBy: "Sam Resnick", status: "Incomplete")
        let punt3 = Punt(slave: "Juan", name: "Kitchen", date: NSDate(), givenBy: "Automatic", status: "Pending")
        
        punts += [punt1, punt2, punt3]
    }
    
    
    var segControl: UISegmentedControl?
    var segment: String {
        if self.segControl == nil {
            return "User"
        } else {
            return (self.segControl!.titleForSegmentAtIndex((self.segControl?.selectedSegmentIndex)!))!
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if punts.count == 0 && indexPath.row == 1 {
            let identifier = Constants.Identifiers.TableViewCells.NoPuntsCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            cell.backgroundColor = Constants.Colors.deltsYellow
            
            return cell
        }
        
        guard indexPath.row < punts.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        if self.segment == "User" {
            let identifier = Constants.Identifiers.TableViewCells.PuntTableViewCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntsTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            // right buttons
            let makeupButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.redColor())
            cell.rightButtons = [makeupButton]
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.delegate = self
            
            let punt = punts[indexPath.row]
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            // TODO: Real
            cell.checkoffImageView?.image = Constants.Photos.BlackCircle
            
            return cell
            
        } else /*if self.segment == "Admin"*/ {
            let identifier = Constants.Identifiers.TableViewCells.PuntAdminCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntAdminTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            // right buttons
            let makeupButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.cyanColor())
            let deleteButton = MGSwipeButton(title: "", icon: Constants.Photos.Punt, backgroundColor: UIColor.redColor())
            cell.rightButtons = [deleteButton, makeupButton]
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.delegate = self
            
            
            let punt = punts[indexPath.row]
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            cell.slaveLabel.text = punt.slave
            // TODO: Real
            cell.statusImageView?.image = Constants.Photos.BlackCircle
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(15, punts.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    // Go to detail punt view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case Constants.Identifiers.Segues.UserPuntDetailSegue:
            let cell = sender as! PuntsTableViewCell
            let controller = segue.destinationViewController as! PuntDetailViewController
            controller.punt = cell.punt
            controller.role = 0
            
            break
        case Constants.Identifiers.Segues.AdminPuntDetailSegue:
            let cell = sender as! PuntAdminTableViewCell
            let controller = segue.destinationViewController as! PuntDetailViewController
            controller.punt = cell.punt
            
        default: break
        }

    }
    
    // MARK: Punt Loading
    func loadUserPunts() {
        //
    }
    
    func loadAdminPunts() {
        //
    }
    
    // MARK: MGSwipeTableCellDelegate
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch self.segment {
        case "User":
            print("User request punt makeup")
            userRequestMakeup()
            break
        case "Admin":
            switch index {
            case 0:
                print("Admin delete punt")
                adminDeletePunt()
                break
            case 1:
                print("Admin makeup punt")
                adminMakeupPunt()
                break
            default:
                break
            }
        default:
            break
        }
        return true
    }

    // Actions
    func userRequestMakeup() {
        //
    }
    
    func adminDeletePunt() {
        //
    }
    
    func adminMakeupPunt() {
        //
    }
}
