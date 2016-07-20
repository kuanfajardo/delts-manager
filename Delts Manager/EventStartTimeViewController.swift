//
//  EventStartTimeViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventStartTimeViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: Properties
    var delegate: PartyPlannerDelegate?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        let currentDate = NSDate()
        self.datePicker.minimumDate = currentDate
        self.datePicker.date = currentDate
    }
    
    func donePressed() {
        self.delegate?.passStartTimeBack!(self.datePicker.date)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}
