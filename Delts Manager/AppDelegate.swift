//
//  AppDelegate.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Override point for customization after application launch.
        let standardDefaults = NSUserDefaults.standardUserDefaults()
        
        let appDefaults: [String : AnyObject] = [
            // Log In
            Constants.DefaultsKeys.LoggedIn : true,
            
            // User Info
            Constants.DefaultsKeys.Name : "Juan",
            Constants.DefaultsKeys.ID : 0,
            Constants.DefaultsKeys.Email : "jfajardo@mit.edu",
            Constants.DefaultsKeys.Roles : [0,1,2,5],
            
            // Notifications
            Constants.DefaultsKeys.Notifications : true,
            Constants.DefaultsKeys.DutyReminders : true,
            Constants.DefaultsKeys.DutyTime : "08:00",
            Constants.DefaultsKeys.PuntMakupPosted : true,
            Constants.DefaultsKeys.CheckoffNotification : true,
            Constants.DefaultsKeys.PuntNotification : true,
            
            // Enabled
            Constants.DefaultsKeys.ScheduleEnabled : true,
            
            // Other
            Constants.DefaultsKeys.Punts : 3,
            Constants.DefaultsKeys.Duties : 4
        ]

        standardDefaults.registerDefaults(appDefaults)
        
        let loggedIn = Constants.defaults.boolForKey(Constants.DefaultsKeys.LoggedIn)
        
        if loggedIn {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.Identifiers.Controllers.TabController)
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

