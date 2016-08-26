//
//  Functions.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

struct Functions {
    static func presentAPIErrorOn(view: UIViewController, withTitle title: String = "Oops!", withMessage message: String = "Not able to load data- Ini took a dump on the server. \nPlease try again.") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        view.presentViewController(alertController, animated: true, completion: nil)
    }
}

