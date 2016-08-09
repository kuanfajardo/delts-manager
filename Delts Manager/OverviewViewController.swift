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
        if self.checkoffImageView.userInteractionEnabled {
            print("checkoff button pressed")
        }
    }
    
    @IBAction func puntMakeupPressed() {
        if self.puntMakeupImageView.userInteractionEnabled {
            print("punt button pressed")
        }
    }
    
    @IBAction func schedulePressed(sender: UITapGestureRecognizer) {
        // TODO: Make check for type of schedule (party v house) one or both?
        guard self.scheduleImageView.userInteractionEnabled else {
            return
        }
        
        let identifier = Constants.Identifiers.Controllers.DutySelectorController
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! DutySelectorTableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: Helper functions
    func setUI() {
        //let checkoffEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.CheckoffEnabled)
        let numDuties = Constants.defaults.integerForKey(Constants.DefaultsKeys.Duties)
        let numPunts = Constants.defaults.integerForKey(Constants.DefaultsKeys.Punts)
        let scheduleEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.ScheduleEnabled)
        
        // Duty Section
        self.checkoffImageView.userInteractionEnabled = (numDuties != 0)
        self.checkoffImageView.image = imageFromNumber(numDuties)
        self.dutyLabel.text = (numDuties != 0) ? "\(numDuties)" : "No Duties Today :)"

        // Punts Section
        self.puntLabel.text = "\(numPunts)"
        self.puntMakeupImageView.image = imageFromNumber(numPunts)
        self.puntMakeupImageView.userInteractionEnabled = !(numPunts == 0)
        
        
        // Schedule Section
        self.scheduleImageView.userInteractionEnabled = scheduleEnabled
        self.scheduleLabel.text = scheduleEnabled ? "Open" : "Closed: Friday 5:00"
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
