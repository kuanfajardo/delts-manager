//
//  DutySelectorCell
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/8/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class DutySelectorCell: UITableViewCell {
    // MARK: Properties
    var duty: Duty?
    var houseDuty: HouseDuty?
    //var enabled = [Bool]()
    var delegate: UIViewController?
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    
    // MARK: Actions
    // IB
    @IBAction func mondayButtonPressed() {
        buttonPressedForDay(1)
    }
    
    @IBAction func tuesdayButtonPressed() {
        buttonPressedForDay(2)
    }
    
    @IBAction func wednesdayButtonPressed() {
        buttonPressedForDay(3)
    }
    
    @IBAction func thursdayButtonPressed() {
        buttonPressedForDay(4)
    }
    
    @IBAction func fridayButtonPressed() {
        buttonPressedForDay(5)
    }
    
    // MARK: main action
    func buttonPressedForDay(dayOfWeek: Int) {
        let availability = self.houseDuty!.availabilities[dayOfWeek]
        let claim: Bool?
        var alertMessage = ""
        
        print(self.houseDuty?.name)
        print(availability)
        
        switch availability {
        case .Open:
            claim = true
            break
        case .Selected:
            claim = false
            break
        case .Taken:
            claim = nil
            alertMessage = "This duty is taken by \(self.houseDuty!.takers[dayOfWeek])"
            break
        case .Unavailable:
            claim = nil
            alertMessage = "This duty is grey. Grey = Unavailable. How are you at MIT."
        }
        
        print(claim)
        print(alertMessage)
        
        guard claim != nil else {
            Functions.presentAPIErrorOn(self.delegate!, withTitle: "Nope. Stop.", withMessage: alertMessage)
            return
        }
        
        let dutyID = self.houseDuty!.ids[dayOfWeek]
        
        updateHouseDuty(withID: dutyID, forClaim: claim!)
    }
    
    

    func updateHouseDuty(withID dutyID: Int, forClaim claim: Bool) {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.DutyID : dutyID,
            Constants.AlamoKeys.Claim : claim
        ] as! [String : AnyObject]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.UpdateHouseDuty)) for \(dutyID) claim \(claim)")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.UpdateHouseDuty), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let statusCode = try json.int("status")
                    
                    let alertTitle = statusCode == 1 ? "Success!" : "Fail"
                    let alertMessage = statusCode == 1 ? "Duty \(claim == true ? "claimed" : "disclaimed") successfully" : "Something went wrong."
                    
                    Functions.presentAPIErrorOn(self.delegate!, withTitle: alertTitle, withMessage: alertMessage)
                    
                    return
                    
                } catch {
                    //Functions.presentAPIErrorOn(self.delegate!, withTitle: "Oops!", withMessage: "Not able to update house duty.")
                    print("Error in updateHouseDuties")
                }
        }
    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
}
