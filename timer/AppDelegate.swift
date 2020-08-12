//
//  AppDelegate.swift
//  timer
//
//  Created by Macbook Air on 09.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = StopwatchViewController()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("applicationWillTerminate"), object: nil)
        print("applicationWillTerminate")
    }

}
