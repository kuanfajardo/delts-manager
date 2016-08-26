//
//  OverviewViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/5/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import GBDeviceInfo
import Alamofire
import Freddy

class OverviewViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var checkoffImageView: UIImageView!
    @IBOutlet weak var puntMakeupImageView: UIImageView!
    @IBOutlet weak var scheduleImageView: UIImageView!
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var puntLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var scheduleDetailLabel: UILabel!
    
    @IBOutlet weak var dutyImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var puntImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleImageLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var puntLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleLabelRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dutyLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var puntLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleLabelWidthConstraint: NSLayoutConstraint!
    
    
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
        setAllUI()

    }
    
    override func viewWillAppear(animated: Bool) {
        setImageUI()
    }
    
    // MARK: Helper functions
    func setAllUI() {
        /*getStats()
        
        let numDuties = Constants.defaults.integerForKey(Constants.DefaultsKeys.Duties)
        let numPunts = Constants.defaults.integerForKey(Constants.DefaultsKeys.Punts)
        let scheduleEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.ScheduleEnabled)
        
        // Duty Section
        self.checkoffImageView.userInteractionEnabled = (numDuties != 0)
        self.checkoffImageView.image = imageFromNumber(numDuties)

        // Punts Section
        self.puntMakeupImageView.image = imageFromNumber(numPunts)
        self.puntMakeupImageView.userInteractionEnabled = !(numPunts == 0)
        
        // Schedule Section
        self.scheduleImageView.userInteractionEnabled = scheduleEnabled
        self.scheduleImageView.alpha = scheduleEnabled ? 1 : 0.5
        self.scheduleDetailLabel.text = scheduleEnabled ? "Open" : "Closed"
        */
        
        // TODO: lololll
        let isBigPhone = true//(GBDeviceInfo.deviceInfo().deviceVersion.major >= 7)//true
        
        self.dutyImageLeftConstraint.constant = isBigPhone ? 22 : 10
        self.puntImageLeftConstraint.constant = isBigPhone ? 22 : 10
        self.scheduleImageLeftConstraint.constant = isBigPhone ? 22 : 10
        
        self.puntLabelRightConstraint.constant = isBigPhone ? 25 : 58
        self.scheduleLabelRightConstraint.constant = isBigPhone ? 25 : 56
        
        self.dutyLabelWidthConstraint.constant = isBigPhone ? 160 : 129
        self.puntLabelWidthConstraint.constant = isBigPhone ? 155 : 124
        self.scheduleLabelWidthConstraint.constant = isBigPhone ? 155 : 124
        
        if isBigPhone {
            //self.dutyPuntLeadingConstraint.priority = 0
            //self.puntScheduleLeadingConstraint.priority = 0
        } else {
            //self.puntScheduleLeadingConstraint.priority = 1000
            //self.dutyPuntLeadingConstraint.priority = 1000
        }
        
        self.dutyLabel.frame = isBigPhone ? CGRect(x: 360, y: 45, width: 160, height: 26) : CGRect(x: 391, y: 45, width: 129, height: 26)
        self.puntLabel.frame = isBigPhone ? CGRect(x: 360, y: 45, width: 122, height: 26) : CGRect(x: 391, y: 45, width: 124, height: 26)
        self.scheduleDetailLabel.frame = isBigPhone ? CGRect(x: 360, y: 66, width: 100.5, height: 18) : CGRect(x: 391, y: 66, width: 100.5, height: 18)
        self.scheduleLabel.frame = isBigPhone ? CGRect(x: 360, y: 33, width: 124, height: 26) : CGRect(x: 391, y: 33, width: 124, height: 26)
        
        self.checkoffImageView.frame = isBigPhone ? CGRect(x: 22, y: 8, width: 100, height: 100) : CGRect(x: 10, y: 8, width: 100, height: 100)
        self.puntMakeupImageView.frame = isBigPhone ? CGRect(x: 22, y: 8, width: 100, height: 100) : CGRect(x: 10, y: 8, width: 100, height: 100)
        self.scheduleImageView.frame = isBigPhone ? CGRect(x: 22, y: 8, width: 100, height: 100) : CGRect(x: 10, y: 8, width: 100, height: 100)
        
        self.dutyLabel.text = isBigPhone ? "Upcoming Duties" : "Duties"
        self.puntLabel.text = isBigPhone ? "Current Punts" : "Punts"
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
            return Constants.Photos.PurpleCircle
        }
    }
    
    func setImageUI() {
        getStats()
        
        let numDuties = Constants.defaults.integerForKey(Constants.DefaultsKeys.Duties)
        let numPunts = Constants.defaults.integerForKey(Constants.DefaultsKeys.Punts)
        let scheduleEnabled = Constants.defaults.boolForKey(Constants.DefaultsKeys.ScheduleEnabled)
        
        // Duty Section
        self.checkoffImageView.userInteractionEnabled = (numDuties != 0)
        self.checkoffImageView.image = imageFromNumber(numDuties)
        
        // Punts Section
        self.puntMakeupImageView.image = imageFromNumber(numPunts)
        self.puntMakeupImageView.userInteractionEnabled = !(numPunts == 0)
        
        // Schedule Section
        self.scheduleImageView.userInteractionEnabled = scheduleEnabled
        self.scheduleImageView.alpha = scheduleEnabled ? 1 : 0.5
        self.scheduleDetailLabel.text = scheduleEnabled ? "Open" : "Closed"
    }
    
    func getStats() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!
        ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.AccountStats))")
        Alamofire.request(.GET, DeltURLWithMethod(Constants.Networking.Methods.AccountStats), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let numDuties = try json.int("num_duties")
                    let numPunts = try json.int("num_punts")
                    let scheduleOpen = try json.bool("schedule_open")
                    
                    Constants.defaults.setInteger(numDuties, forKey: Constants.DefaultsKeys.Duties)
                    Constants.defaults.setInteger(numPunts, forKey: Constants.DefaultsKeys.Punts)
                    Constants.defaults.setBool(scheduleOpen, forKey: Constants.DefaultsKeys.ScheduleEnabled)
                    
                } catch {
                    //Functions.presentAPIErrorOn(self)
                    print("Error in getStats")
                }
        }
    }

    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }

}
