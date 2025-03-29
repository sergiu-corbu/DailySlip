//
//  AppDelegate.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var rootCoordinator: RootCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let newWindow = UIWindow(frame: UIScreen.main.bounds)
    rootCoordinator = RootCoordinator(window: newWindow, launchOptions: launchOptions)
    rootCoordinator?.start(animated: true)
    self.window = newWindow
    
    return true
  }
}
