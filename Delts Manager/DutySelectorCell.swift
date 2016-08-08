//
//  DutySelectorCell
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/8/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func tuesdayButtonPressed() {
        print("tuesday")
        print(tuesdayButton.tag)
    }
    
    @IBAction func wednesdayButtonPressed() {
        print("wednesday")
        print(wednesdayButton.tag)
    }
    
    @IBAction func thursdayButtonPressed() {
        print("thursday")
        print(thursdayButton.tag)
    }
    
    @IBAction func fridayButtonPressed() {
        print("friday")
        print(fridayButton.tag)
    }
}
