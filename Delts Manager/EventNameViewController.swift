//
//  EventNameViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/20/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class EventNameViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var eventNameTextField: UITextField!
    
    // MARK: Properties
    var delegate: PartyPlannerDelegate?
    var placeholderText: String?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventNameTextField.delegate = self
        self.eventNameTextField.text = placeholderText ?? ""
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    func donePressed() {
        self.delegate?.passNameBack!(eventNameTextField.text!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        donePressed()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.navigationItem.rightBarButtonItem?.enabled = string.characters.count > 0
        return true
    }
    @IBAction func userDidTapView(sender: AnyObject) {
        self.eventNameTextField.resignFirstResponder()
    }

}
