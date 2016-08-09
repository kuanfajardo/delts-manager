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
            self.segControl = UISegmentedControl(items: [Segment.User, Segment.Admin/*, "Makeups"*/])
            
            self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
            self.segControl!.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
            self.segControl!.selectedSegmentIndex = 0
            
            self.navigationItem.titleView = self.segControl
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addPressed))
            rightAddButton.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
            
            self.navigationItem.rightBarButtonItem = rightAddButton

        }
        
        //loadPunts()
        loadSamplePunts()
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        // Reload correct set of punts
        switch self.segment {
        case Segment.User:
            loadUserPunts()
            break
        case Segment.Admin:
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
        let punt1 = Punt(slave: "Juan", name: "Pantry", date: NSDate(), givenBy: "Erick Friis", status: .JustThere)
        let punt2 = Punt(slave: "Juan", name: "Pantry", date: NSDate(), givenBy: "Sam Resnick", status: .Madeup)
        let punt3 = Punt(slave: "Juan", name: "Kitchen", date: NSDate(), givenBy: "Automatic", status: .MakeupRequested)
        
        punts += [punt1, punt2, punt3]
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
        static let Admin = "Admin"
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if punts.count == 0 && indexPath.row == 1 {
            let identifier = Constants.Identifiers.TableViewCells.NoPuntsCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            cell.backgroundColor = UIColor.flatWatermelonColorDark()
            
            return cell
        }
        
        guard indexPath.row < punts.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatWatermelonColor()//Constants.Colors.deltsYellow
            } else {
                cell.backgroundColor = UIColor.flatWatermelonColorDark()//Constants.Colors.deltsYellow
            }
            
            cell.userInteractionEnabled = false
            
            return cell
        }
        
        if self.segment == Segment.User {
            let identifier = Constants.Identifiers.TableViewCells.PuntTableViewCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntsTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.flatWatermelonColor()//Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = UIColor.flatWatermelonColorDark()//Constants.Colors.deltsYellow
            }
            
            cell.puntLabel.textColor = UIColor.flatWhiteColor()
            cell.dateLabel.textColor = UIColor.flatWhiteColor()
            
            let punt = punts[indexPath.row]

            // right buttons
            cell.rightButtons = buttonsFromStatus(punt.status)
            cell.rightExpansion.fillOnTrigger = true
            cell.rightExpansion.buttonIndex = 0
            cell.rightSwipeSettings.transition = .Static
            cell.delegate = self
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            cell.checkoffImageView?.image = imageFromStatus(punt.status)
            
            return cell
            
        } else /*if self.segment == Segment.Admin*/ {
            let identifier = Constants.Identifiers.TableViewCells.PuntAdminCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntAdminTableViewCell
            
            if indexPath.row % 2 == 1 {
                cell.backgroundColor = UIColor.flatWatermelonColorDark()//Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = UIColor.flatWatermelonColor()//Constants.Colors.deltsYellow
            }
            
            
            
            cell.puntLabel.textColor = UIColor.flatWhiteColor()
            cell.dateLabel.textColor = UIColor.flatWhiteColor()
            cell.slaveLabel.textColor = UIColor.flatWhiteColor()
            
            let punt = punts[indexPath.row]

            // right buttons
            cell.rightButtons = buttonsFromStatus(punt.status)
            cell.rightExpansion.fillOnTrigger = true
            if punt.status == .JustThere {
                cell.rightExpansion.buttonIndex = 0
            } else {
                cell.rightExpansion.buttonIndex = 1
            }
            cell.rightSwipeSettings.transition = .Static
            cell.delegate = self
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            cell.slaveLabel.text = punt.slave
            cell.statusImageView?.image = imageFromStatus(punt.status)
            
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
        case Segment.User:
            print("User request punt makeup")
            userRequestMakeup()
            break
        case Segment.Admin:
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
    
    // MARK: Helper
    func imageFromStatus(status: PuntStatus) -> UIImage {
        switch status {
        case .JustThere:
            return Constants.Photos.WhiteAttention
        case .Madeup:
            return Constants.Photos.GreenCheck
        case .MakeupRequested:
            return Constants.Photos.Clock
        }
    }
    
    func buttonsFromStatus(status: PuntStatus) -> [MGSwipeButton] {
        let makeupButton = MGSwipeButton(title: "", icon: Constants.Photos.Duty, backgroundColor: UIColor.flatGreenColor())
        let deleteButton = MGSwipeButton(title: "", icon: Constants.Photos.Punt, backgroundColor: UIColor.flatRedColor())
        
        let noButtons = [MGSwipeButton]()
        
        switch self.segment {
        case Segment.User:
            switch status {
            case .JustThere:
                return [makeupButton]
            default:
                return noButtons
            }
        case Segment.Admin:
            switch status {
            case .JustThere:
                return [deleteButton]
            case .MakeupRequested:
                return [deleteButton, makeupButton]
            case .Madeup:
                return noButtons
            }
        default:
            return noButtons
        }
    }
}
