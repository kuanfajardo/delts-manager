//
//  PuntsTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import Alamofire
import Freddy

class PuntsTableViewController: UITableViewController, MGSwipeTableCellDelegate {
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.HonorBoard) || Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
            self.segControl = UISegmentedControl(items: [Segment.User, Segment.Admin/*, "Makeups"*/])
            
            self.segControl!.addTarget(self, action: #selector(reloadData), forControlEvents: .ValueChanged)
            self.segControl!.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
            self.segControl!.selectedSegmentIndex = 0
            
            self.navigationItem.titleView = self.segControl
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addPressed))
            rightAddButton.tintColor = UIColor.flatWhiteColor()//Constants.Colors.deltsDarkPurple
            
            self.navigationItem.rightBarButtonItem = rightAddButton

        }
        
        loadUserPunts()
        loadSamplePunts()
    }
    
    func reloadData() {
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
        }
        alertController.addAction(cancelAction)
        
        let puntAction = UIAlertAction(title: "New Punt", style: .Default) { (action) in
            self.initiateNewPunt()
        }
        alertController.addAction(puntAction)

        
        let puntMakeupAction = UIAlertAction(title: "New Punt Makeup", style: .Default) { (action) in
            print("New Punt Makeup")
        }
        alertController.addAction(puntMakeupAction)

        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Properties:
    var punts = [Punt]()
    
    func loadSamplePunts() {
        let punt1 = Punt(slave: "Juan", name: "Pantry", id: 1, date: NSDate(), givenBy: "Erick Friis", status: .JustThere)
        let punt2 = Punt(slave: "Juan", name: "Pantry", id: 2, date: NSDate(), givenBy: "Sam Resnick", status: .Madeup)
        let punt3 = Punt(slave: "Juan", name: "Kitchen", id: 3, date: NSDate(), givenBy: "Automatic", status: .MakeupRequested)
        
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
            
            cell.tag = indexPath.row
            
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
            
            cell.tag = indexPath.row
            
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
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!
        ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.AccountPunts))")
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.AccountPunts), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let numPunts = try json.array(0).count
                    var newPunts = [Punt]()
                    
                    for x in 0..<numPunts {
                        let id = try json.int(0, x, "punt_id")
                        let dateString = try json.string(0, x, "timestamp")
                        let givenBy = try json.string(0, x, "given_by")
                        let comments = try json.string(0, x, "comment   ")
                        let makeupGivenBy = try json.string(0, x, "makeup_given_by")
                        let makeupDateString = try json.string(0, x, "makeup_timestamp")
                        let makeupComment = try json.string(0, x, "makeup_comment")
                        
                        let slave = Constants.defaults.stringForKey(Constants.DefaultsKeys.Name)!
                        
                        let punt = Punt(slave: slave, id: id, givenBy: givenBy, comment: comments, makeupGivenBy: makeupGivenBy, makeupComment: makeupComment, dateString: dateString, makeupDateString: makeupDateString)
                        
                        newPunts.append(punt)
                    }
                    
                    self.punts = newPunts

                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in loadUserPunts")
                }
        }
    }
    
    func loadAdminPunts() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!
        ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.ManagerPunts))")
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.ManagerPunts), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let numPunts = try json.array(0).count
                    var newPunts = [Punt]()
                    
                    for x in 0..<numPunts {
                        let id = try json.int(0, x, "punt_id")
                        let dateString = try json.string(0, x, "timestamp")
                        let givenBy = try json.string(0, x, "given_by")
                        let puntSlave = try json.string(0, x, "punted_user_name")
                        let comments = try json.string(0, x, "comment   ")
                        let makeupGivenBy = try json.string(0, x, "makeup_given_by")
                        let makeupDateString = try json.string(0, x, "makeup_timestamp")
                        let makeupComment = try json.string(0, x, "makeup_comment")
                        
                        let punt = Punt(slave: puntSlave, id: id, givenBy: givenBy, comment: comments, makeupGivenBy: makeupGivenBy, makeupComment: makeupComment, dateString: dateString, makeupDateString: makeupDateString)
                        
                        newPunts.append(punt)
                    }
                    
                    /*
                    // OR
                    let puntsJSON = try json.array(0)
                    for x in 0..<numPunts {
                        let puntJSON = puntsJSON[x]
                        
                        let id = try puntJSON.int("punt_id")
                        let dateString = try puntJSON.string("timestamp")
                        let givenBy = try puntJSON.string("given_by")
                        let puntSlave = try puntJSON.string("punted_user_name")
                        let comments = try puntJSON.string("comment   ")
                        let makeupGivenBy = try puntJSON.string("makeup_given_by")
                        let makeupDateString = try puntJSON.string("makeup_timestamp")
                        let makeupComment = try puntJSON.string("makeup_comment")
                        
                        let punt = Punt(slave: puntSlave, id: id, givenBy: givenBy, comment: comments, makeupGivenBy: makeupGivenBy, makeupComment: makeupComment, dateString: dateString, makeupDateString: makeupDateString)
                        
                        newPunts.append(punt)
                    }*/
                    
                     /*
                    // OR
                    let allPuntsJSON = try json.array(0)
                    for x in 0..<numPunts {
                        let puntJSON = allPuntsJSON[x]
                        let punt = try Punt(json: puntJSON, type: "Admin")
                        newPunts.append(punt)
                    }
                    */
                    
                    self.punts = newPunts
                
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in loadAdminPunts")
                }
        }
    }
    
    // MARK: MGSwipeTableCellDelegate
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let cellID = punts[cell.tag].id
        
        switch self.segment {
        case Segment.User:
            print("User request punt makeup")
            userRequestMakeup(cellID)
            break
        case Segment.Admin:
            switch index {
            case 0:
                print("Admin delete punt")
                adminDeletePunt(cellID)
                break
            case 1:
                print("Admin makeup punt")
                adminMakeupPunt(cellID)
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
    // to be implemented by API
    func userRequestMakeup(id: Int) {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!,
            Constants.AlamoKeys.PuntedID : id
        ] as! [String : AnyObject]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.AccountRequestPuntMakeup))")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.AccountRequestPuntMakeup), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in userRequestMakeup")
                }
        }
    }
    
    // to be implemented by api
    func adminDeletePunt(id: Int) {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!,
            Constants.AlamoKeys.PuntedID : id
            ] as! [String : AnyObject]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.ManagerDeletePunt))")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.ManagerDeletePunt), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in adminDeletePunts")
                }
        }
    }
    
    // to be implemented with api
    func adminMakeupPunt(id: Int) {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.PuntedID : id
            ] as! [String : AnyObject]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.ManagerMakeupPunt))")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.ManagerMakeupPunt), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in adminMakeupPunt")
                }
        }
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
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
    
    func initiateNewPunt() {
        let identifier = Constants.Identifiers.Controllers.NewPuntController
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! NewPuntPersonChooserTableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
