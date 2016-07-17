//
//  OverviewViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/5/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var checkoffImageView: UIImageView!
    @IBOutlet weak var puntMakeupImageView: UIImageView!
    @IBOutlet weak var scheduleImageView: UIImageView!
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var puntLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    // MARK: Actions
    @IBAction func checkoffPressed() {
        print("checkoff button pressed")
    }
    
    @IBAction func puntMakeupPressed() {
        print("punt button pressed")
    }
    
    @IBAction func schedulePressed() {
        print("schedule button pressed")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    func setUI() {
        let checkoffEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.CheckoffEnabled)
        let numPunts = Constants.defaults.integerForKey(Constants.DefaultsKeys.Punts)
        let scheduleEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.ScheduleEnabled)
        
        // Duty Section
        self.checkoffImageView.userInteractionEnabled = checkoffEnabled
        
        if checkoffEnabled {
            //self.dutyLabel.text =
        } else {
            self.dutyLabel.text = "No Duties Today :)"
        }
        
        // Punts Section
        self.puntLabel.text = "\(numPunts)"
        
        if numPunts > 0 {
            self.puntMakeupImageView.userInteractionEnabled = true
        } else {
            self.puntMakeupImageView.userInteractionEnabled = true
        }
        
        // Schedule Section
        self.scheduleLabel.userInteractionEnabled = scheduleEnabled
        
        if scheduleEnabled {
            self.scheduleLabel.text = "Open"
        } else {
            self.scheduleLabel.text = "Closed: Friday 5:00"
        }
    }
    
}
