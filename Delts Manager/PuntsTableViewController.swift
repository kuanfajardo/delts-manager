//
//  PuntsTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PuntsTableViewController: UITableViewController {
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check roles for user content
        if Constants.userAuthorized(Constants.Roles.HonorBoard) || Constants.userAuthorized(Constants.Roles.HouseManager) || Constants.userAuthorized(Constants.Roles.Admin) {
            self.segControl = UISegmentedControl(items: ["User", "Admin", "Makeups"])
            
            self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
            self.segControl!.tintColor = Constants.Colors.deltsDarkPurple
            self.segControl!.selectedSegmentIndex = 0
            
            self.navigationItem.titleView = self.segControl
            
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addPressed))
            rightAddButton.tintColor = Constants.Colors.deltsPurple
            
            self.navigationItem.rightBarButtonItem = rightAddButton

        }
        
        //loadPunts()
        loadSamplePunts()
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func addPressed() {
        //
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
        
        guard indexPath.row < punts.count else {
            let identifier = Constants.Identifiers.TableViewCells.PlainCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsLightPurple
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
                cell.backgroundColor = Constants.Colors.deltsLightPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            let punt = punts[indexPath.row]
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            // TODO: Real
            cell.checkoffImageView?.image = UIImage(named: Constants.Photos.BlackCircle)
            
            return cell
            
        } else /*if self.segment == "Admin"*/ {
            let identifier = Constants.Identifiers.TableViewCells.PuntAdminCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntAdminTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsLightPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            
            let punt = punts[indexPath.row]
            
            cell.punt = punt
            cell.puntLabel.text = punt.name
            cell.dateLabel.text = punt.dateString
            cell.slaveLabel.text = punt.slave
            // TODO: Real
            cell.statusImageView?.image = UIImage(named: Constants.Photos.BlackCircle)
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(25, punts.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Navigation
    
    // Go to detail punt view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! PuntDetailViewController
        let cell = sender as! PuntsTableViewCell
        
        controller.punt = cell.punt
    }
    

}
