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
        print("monday")
        print(mondayButton.tag)
        updateHouseDuties()
    }
    
    @IBAction func tuesdayButtonPressed() {
        print("tuesday")
        print(tuesdayButton.tag)
        updateHouseDuties()
    }
    
    @IBAction func wednesdayButtonPressed() {
        print("wednesday")
        print(wednesdayButton.tag)
        updateHouseDuties()
    }
    
    @IBAction func thursdayButtonPressed() {
        print("thursday")
        print(thursdayButton.tag)
        updateHouseDuties()
    }
    
    @IBAction func fridayButtonPressed() {
        print("friday")
        print(fridayButton.tag)
        updateHouseDuties()
    }
    
    
    // TODO: how to implement - update all duties at same time? or one at a time when pressed? when pressed done? or on duty? reflect with constant as well
    func updateHouseDuties() {
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token
        ]
        
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.UpdateHouseDuty))")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.UpdateHouseDuty), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    print("Error in updateHouseDuties")
                }
        }
    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
}
