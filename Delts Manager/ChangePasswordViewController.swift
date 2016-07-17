//
//  ChangePasswordViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/4/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    // MARK: Actions
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func buttonPressed() {
        
        guard ((newPasswordField.text?.characters.count) > 8) else {
            displayError("Password too short")
            return
        }
        
        guard newPasswordField.text == repeatPasswordField.text else{
            displayError("Passwords do not match")
            return
        }
        
        userDidTapView(self)
        updatePassword()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(newPasswordField)
        resignIfFirstResponder(repeatPasswordField)
    }

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newPasswordField.delegate = self
        self.repeatPasswordField.delegate = self
        
        self.newPasswordField.accessibilityIdentifier = Constants.Identifiers.TextFields.NewPasswordField
        self.repeatPasswordField.accessibilityIdentifier = Constants.Identifiers.TextFields.RepeatPasswordField
        
    }
    
    func displayError(error: String) {
        self.debugTextLabel.text = error
    }
    
    func updatePassword() {
        // TODO: Implement real functionality
        Constants.Settings.password = newPasswordField.text!
    }
    
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField.accessibilityIdentifier! {
            case Constants.Identifiers.TextFields.NewPasswordField:
                textField.resignFirstResponder()
                repeatPasswordField.becomeFirstResponder()
            case Constants.Identifiers.TextFields.RepeatPasswordField:
                textField.resignFirstResponder()
                buttonPressed()
            default:
                break
        }
        return true
    }
    
    // MARK: Keyboard
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    func setUIEnabled(enabled: Bool) {
        newPasswordField.enabled = enabled
        repeatPasswordField.enabled = enabled
        okButton.enabled = enabled
        
        // adjust login button opacity
        if enabled {
            okButton.alpha = 1.0
        } else {
            okButton.alpha = 0.5
        }
    }
 
    
}
