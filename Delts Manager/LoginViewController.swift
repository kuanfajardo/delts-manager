//
//  LoginViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: Actions
    @IBAction func loginPressed() {
        // TODO: Code for login
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            //debugTextLabel.text = "Username or Password Empty."
        } else {
            setUIEnabled(false)
            authenticateLogin()
        }
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // TODO: make status bar white
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Authentication
    private func authenticateLogin() {
        // TODO: Later, implement actual login procedure
        if emailTextField.text! == Constants.UserInfo.email && passwordTextField.text! == Constants.UserInfo.password {
            completeLogin()
        } else {
            setUIEnabled(true)
        }
    }
    
    private func completeLogin() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("TabController") as! UITabBarController
        self.presentViewController(controller, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: LoginViewController - UITextFieldDelegate and Keyboard
extension LoginViewController: UITextFieldDelegate {
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField.accessibilityIdentifier! {
            case "Email Field":
                textField.resignFirstResponder()
                passwordTextField.becomeFirstResponder()
            case "Password Field":
                textField.resignFirstResponder()
                loginPressed()
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
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(emailTextField)
        resignIfFirstResponder(passwordTextField)
    }
}


// MARK: LoginViewController - Configure UI
extension LoginViewController {
    
    func setUIEnabled(enabled: Bool) {
        emailTextField.enabled = enabled
        passwordTextField.enabled = enabled
        loginButton.enabled = enabled
        
        // adjust login button opacity
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
}
