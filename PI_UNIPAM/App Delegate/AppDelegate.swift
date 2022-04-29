//
//  AppDelegate.swift
//  PI UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit
import FirebaseCore

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
