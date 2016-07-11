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
        loadSamplePunts()
    }
    
    // MARK: Properties:
    var punts = [Punt]()
    
    func loadSamplePunts() {
        let punt1 = Punt(name: "Pantry", date: NSDate(), givenBy: "Erick Friis", status: "Completed")
        let punt2 = Punt(name: "Pantry", date: NSDate(), givenBy: "Sam Resnick", status: "Incomplete")
        let punt3 = Punt(name: "Kitchen", date: NSDate(), givenBy: "Automatic", status: "Pending")
        
        punts += [punt1, punt2, punt3]
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "PuntTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PuntsTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Constants.Colors.deltsLightPurple
        } else {
            cell.backgroundColor = Constants.Colors.deltsYellow
        }
        
        guard indexPath.row < punts.count else {
            cell.puntLabel.text = ""
            cell.dateLabel.text = ""
            cell.checkoffImageView?.image = nil
            
            return cell
        }
        
        let punt = punts[indexPath.row]
        
        cell.punt = punt
        cell.puntLabel.text = punt.name
        cell.dateLabel.text = punt.dateString
        // TODO: Real
        cell.checkoffImageView?.image = UIImage(named: "first")
        
        return cell
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