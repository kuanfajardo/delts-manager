//
//  AppDelegate.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/24/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import PermissionScope

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        print(launchOptions)
        
        registerForPushNotifications(application)
        
        // Override point for customization after application launch.
        let standardDefaults = NSUserDefaults.standardUserDefaults()
        
        let appDefaults: [String : AnyObject] = [
            // Log In
            Constants.DefaultsKeys.LoggedIn : false,
            Constants.DefaultsKeys.Token : 0,
            
            // User Info
            Constants.DefaultsKeys.Name : "Juan", //""
            Constants.DefaultsKeys.ID : 0, //0
            Constants.DefaultsKeys.Email : "jfajardo@mit.edu", //""
            Constants.DefaultsKeys.Roles : [0,1,2,5], //[0]
            
            // Notifications
            Constants.DefaultsKeys.DutyReminders : true,
            Constants.DefaultsKeys.CheckoffGrantedNotification : true,
            Constants.DefaultsKeys.CheckoffRequestedNotification : true,
            Constants.DefaultsKeys.PuntNotification : true,
            Constants.DefaultsKeys.ScheduleOpenedNotification : true,
            
            // Overview
            Constants.DefaultsKeys.Punts : 3, //0
            Constants.DefaultsKeys.Duties : 4, //0
            Constants.DefaultsKeys.ScheduleEnabled : true, //false
            
            // Later
            Constants.DefaultsKeys.DutyTime : "08:00",
            Constants.DefaultsKeys.PuntMakupPosted : true,
            Constants.DefaultsKeys.PuntForgiven : true,
            Constants.DefaultsKeys.PuntMakeupRequested : true,
            Constants.DefaultsKeys.PuntPetitioned : true
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

    func registerForPushNotifications(application: UIApplication) {
        let pscope = PermissionScope()
        pscope.addPermission(NotificationsPermission(notificationCategories: nil), message: "To send death threats")
        
        pscope.permissionButtonTextColor = UIColor.flatMagentaColor()
        pscope.permissionButtonBorderColor = UIColor.flatMagentaColor()
        pscope.closeButton = UIButton()
        pscope.authorizedButtonColor = UIColor.flatGreenColor()
        pscope.unauthorizedButtonColor = UIColor.flatWatermelonColor()
        
        pscope.show({ (finished, results) in
            print("got results \(results)")
            }) { (results) in
                print("cancelled")
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("Device Token: ", tokenString)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("failed to register: ", error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }

}

