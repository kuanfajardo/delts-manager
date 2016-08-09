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
        // TODO: Make check for type of schedule (party v house) one or both?
        print("schedule button pressed")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flatWhiteColor()
        
        setUI()
    }
    
    // MARK: Helper functions
    func setUI() {
        let checkoffEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.CheckoffEnabled)
        let numDuties = Constants.defaults.integerForKey(Constants.DefaultsKeys.Duties)
        let numPunts = Constants.defaults.integerForKey(Constants.DefaultsKeys.Punts)
        let scheduleEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.ScheduleEnabled)
        
        // Duty Section
        self.checkoffImageView.userInteractionEnabled = false//checkoffEnabled
        self.checkoffImageView.image = imageFromNumber(numDuties)
        
        if checkoffEnabled {
            self.dutyLabel.text = "\(numDuties)"
        } else {
            self.dutyLabel.text = "No Duties Today :)"
        }
        
        // Punts Section
        self.puntLabel.text = "\(numPunts)"
        self.puntMakeupImageView.image = imageFromNumber(numPunts)
        
        /*
        if numPunts > 0 {
            self.puntMakeupImageView.userInteractionEnabled = true
        } else {
            self.puntMakeupImageView.userInteractionEnabled = true
        }*/
        
        self.puntMakeupImageView.userInteractionEnabled = false
        
        // Schedule Section
        self.scheduleLabel.userInteractionEnabled = false//scheduleEnabled
        
        if scheduleEnabled {
            self.scheduleLabel.text = "Open"
        } else {
            self.scheduleLabel.text = "Closed: Friday 5:00"
        }
    }
    
    func imageFromNumber(number: Int) -> UIImage {
        switch number {
        case -1:
            return Constants.Photos.Calendar
        case 0:
            return Constants.Photos.SmileyFace
        case 1:
            return Constants.Photos.One
        case 2:
            return Constants.Photos.Two
        case 3:
            return Constants.Photos.Three
        case 4:
            return Constants.Photos.Four
        case 5:
            return Constants.Photos.Five
        case 6:
            return Constants.Photos.Six
        case 7:
            return Constants.Photos.Seven
        case 8:
            return Constants.Photos.Eight
        case 9:
            return Constants.Photos.Nine
        default:
            return Constants.Photos.BlackCircle
        }
    }
    
}
