//
//  LoginViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class LoginViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    
    // MARK: Actions
    @IBAction func loginPressed() {
        // TODO: Code for login
        /*if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            displayError("Empty email and/or password")
        } else {
            setUIEnabled(false)
            debugTextLabel.text = ""
            authenticateLogin()
        }*/
        
        // STEP 1: Authenticate
        authenticateLogin()
        
        // STEP 2: Get User Info
        getLoginInfo()
        
        // STEP 3: Complete / UI Transition
        completeLogin()
    }
    
    // Get Login Stuff
    private func getLoginInfo() {
        // GET Const. NAME, ID, ROLES, EMAIL
        // Set LOGGED IN
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.emailTextField.accessibilityIdentifier = Constants.Identifiers.TextFields.EmailField
        self.passwordTextField.accessibilityIdentifier = Constants.Identifiers.TextFields.PasswordField

        // TODO: make status bar white
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Authentication
    
    // HTTP method for auth
    private func authenticateLogin() {
        // TODO: Later, implement actual login procedure
        /*if emailTextField.text! == Constants.UserInfo.email && passwordTextField.text! == Constants.UserInfo.password {
            completeLogin()
        } else {
            // TODO: more specific debug (ie email doesnt exist, connection bad, etc.)
            displayError("Invalid email/password combination")
            setUIEnabled(true)
        }*/
        
        let methodParameters = [Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey]
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let credentialData = "\(email):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]

        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.Authenticate), parameters: methodParameters, encoding: .JSON, headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                } catch {
                    print("Error")
                }
        }
    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
    
    private func completeLogin() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.TabController) as! UITabBarController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    private func displayError(error: String) {
        debugTextLabel.text = error
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
            case Constants.Identifiers.TextFields.EmailField:
                textField.resignFirstResponder()
                passwordTextField.becomeFirstResponder()
            case Constants.Identifiers.TextFields.PasswordField:
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
