//
//  AppDelegate.swift
//  Calendar
//
//  Created by Abhijeet Choudhary on 06/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow()
    let home: HomeView = HomeBuilder.build()
    let navigationController = UINavigationController(rootViewController: home)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    self.window = window
    
    return true
  }
  
}

