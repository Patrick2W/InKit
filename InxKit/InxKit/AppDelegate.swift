//
//  AppDelegate.swift
//  InxKit
//
//  Created by Patrick W on 2021/4/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KeyboardHelper.helper.shouldResignOnTouchOutside = true
        
        return true
    }
}

