//
//  NewPuntCommentViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/22/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class NewPuntCommentViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var commentTextField: UITextField!
    
    // MARK: Actions
    @IBAction func userDidTapView(sender: UITapGestureRecognizer) {
        if commentTextField.isFirstResponder() {
            commentTextField.resignFirstResponder()
        }
    }
    
    // MARK: Properties
    var slaves: [(String, Int)]?
    var slaveIDs: [Int]? {
        if let slaves = slaves {
            var ids = [Int]()
            
            for s in slaves {
                ids.append(s.1)
            }
            
            return ids
        }
        return nil
    }
    var comment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(donePressed))
        
        self.commentTextField.delegate = self
    }
    
    func donePressed() {
        if commentTextField.isFirstResponder() {
            commentTextField.resignFirstResponder()
        }
        
        self.comment = commentTextField.text!.characters.count == 0 ? "u stupid" : commentTextField.text!
        
        print(comment)
        
        sendPunt()
    }
    
    func sendPunt() {
        var success = true
        
        let methodParameters = [
            Constants.AlamoKeys.ApiKey : Constants.AlamoValues.ApiKey,
            Constants.AlamoKeys.Token : Constants.AlamoValues.Token,
            Constants.AlamoKeys.Email : Constants.defaults.stringForKey(Constants.DefaultsKeys.Email)!,
            Constants.AlamoKeys.PuntedID : self.slaveIDs!,
            Constants.AlamoKeys.Comments : self.comment!
        ] as! [String : AnyObject]
    
        print("Request to \(DeltURLWithMethod(Constants.Networking.Methods.ManagerPunt)) for \(self.slaveIDs)")
        Alamofire.request(.POST, DeltURLWithMethod(Constants.Networking.Methods.ManagerPunt), parameters: methodParameters)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    let json = try JSON(data: response.data!)

                    let statusCode = try json.int("status")

                    success = statusCode == 1

                    var title: String
                    var message: String
                    
                    if success {
                        title = "Punts Sent"
                        message = " You have demonstrated your power successfully"
                    } else {
                        title = "Error"
                        message = "Someting went wrong... Please try again"
                    }

                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .Default) { (_) in
                        if success {
                            self.navigationController?.popViewControllerAnimated(true)
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }
                    
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                } catch {
                    print("Error in sendPunt")
                    
                    let alertController = UIAlertController(title: "Error", message: "Something went wrong... please try again", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))

                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }
    }
    
    func DeltURLWithMethod(method: String) -> String {
        return Constants.Networking.BaseURL + method
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        donePressed()
        return true
    }
}
