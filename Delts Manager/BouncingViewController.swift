//
//  BouncingViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/19/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class BouncingViewController: UIViewController, PartyPlannerExtendedDelegate {
    func passEventBack(value: Event) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(EventPlannerTableViewController) {
            let controller = segue.destinationViewController as! EventPlannerTableViewController
            controller.delegate = self
        }
    }
}
