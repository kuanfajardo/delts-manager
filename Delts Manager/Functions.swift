//
//  Functions.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

func presentAPIErrorOn(view: UIViewController, withMessage message: String = "Ini took a dump on the server") {
    let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(okAction)
    view.presentViewController(alertController, animated: true, completion: nil)
}
