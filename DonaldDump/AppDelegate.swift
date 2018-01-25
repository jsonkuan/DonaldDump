//
//  AppDelegate.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-10.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        OneSignal.initWithLaunchOptions(launchOptions, appId: MY_APP_ID)
    
        UISearchBar.appearance().barTintColor = UIColor.barColor()
        UISearchBar.appearance().tintColor =  UIColor.black
//        UINavigationBar.appearance().barTintColor = UIColor.barColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension UIColor {
    static func appTheme() -> UIColor {
        return UIColor(red: 209.0/255.0, green: 225.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }
   
    static func barColor() -> UIColor {
      return UIColor(red: 40.0/255.0, green: 133.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    }
    
}

