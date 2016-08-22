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
        //authenticateLogin()
        guard digestAuth() else {
            return
        }
        
        // STEP 2: Get User Info
        getLoginInfo()
        
        // STEP 3: Complete / UI Transition
        completeLogin()
    }
    
    // Get Login Stuff
    private func getLoginInfo() {
        // GET Const. NAME, ID, ROLES, EMAIL
        let methodParameters : [String : AnyObject] = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.defaults.integerForKey(Constants.DefaultsKeys.Token),
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!
        ]
        
        let URL = DeltURLWithMethod(Constants.Networking.Methods.AccountInfo)
        
        Alamofire.request(.POST, URL, parameters: methodParameters, encoding: .JSON)
            .responseJSON(completionHandler: { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    
                    let id = try json.int("user_id")
                    let firstName = try json.string("first_name")
                    //let fullName = try json.string("full_name")
                    let privileges = try json.array("privileges")
                    
                    var roles = [Int]()
                    
                    for x in 0..<privileges.count {
                        let role = try json.int("privileges", x)
                        roles += [role]
                    }
                    
                    // Set defaults to parsed data
                    Constants.defaults.setInteger(id, forKey: Constants.DefaultsKeys.ID)
                    Constants.defaults.setValue(firstName, forKey: Constants.DefaultsKeys.Name)
                    Constants.defaults.setValue(roles, forKey: Constants.DefaultsKeys.Roles)
                    
                    
                } catch {
                    print("Error")
                }
            })
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
    
    private func digestAuth() -> Bool {
        let methodParameters = [Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey]
        let method = Constants.Networking.Methods.Authenticate
        let URL = DeltURLWithMethod(method)
        var success = true
        
        Alamofire.request(.POST, URL, parameters: methodParameters, encoding: .JSON)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)
                    // Rest of parsing here
                    let realm = try json.string("realm")
                    let nonce = try json.string("nonce")
                    let opaque = try json.string("opaque")
                    
                    /* for here purpose only
                    let realm = "dtd"
                    let nonce = "1234567890"
                    let opaque = "0987654321"
                    */
                    
                    let email = self.emailTextField.text!
                    let password = self.passwordTextField.text!
                    
                    let a1 = self.md5(string: "\(email):\(realm):\(password)")
                    let a2 = self.md5(string: "\(method):\(URL)")
                    let response = self.md5(string: "\(a1):\(nonce):\(a2)")
                    
                    let methodParameters = [
                        Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
                        Constants.AlamoKeys.Username : "\(email)",
                        Constants.AlamoKeys.Realm : "\(realm)",
                        Constants.AlamoKeys.Nonce : "\(nonce)",
                        Constants.AlamoKeys.Opaque : "\(opaque)",
                        Constants.AlamoKeys.Method : "\(method)",
                        Constants.AlamoKeys.URI : "\(URL)",
                        Constants.AlamoKeys.Response : "\(response)"
                    ]
                        
                       // "Authorization" : "Digest username=\"\(email)\", realm=\"\(realm)\", nonce=\"\(nonce)\", opaque=\"\(opaque)\", uri=\"\(URL)\", response=\"\(response)\""]
                    
                    Alamofire.request(.POST, URL, parameters: methodParameters, encoding: .JSON)
                        .responseJSON(completionHandler: { (response) in
                            do {
                                let newJson = try JSON(data: response.data!)
                                //parse rest of data here
                                let statusCode = try newJson.int("status")
                                
                                success = statusCode == 1

                                guard success else {
                                    return
                                }
                                
                                // Change login stuffff
                                Constants.defaults.setInteger(1, forKey: Constants.DefaultsKeys.Token)
                                Constants.defaults.setBool(true, forKey: Constants.DefaultsKeys.LoggedIn)
                                Constants.defaults.setValue(email, forKey: Constants.DefaultsKeys.Email)
                                
                            } catch {
                                print("Error")
                            }
                    })
                    
                } catch {
                    print("Error")
                }
        }

        return success
    }
    
    private func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
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
