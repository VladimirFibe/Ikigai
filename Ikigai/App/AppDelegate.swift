//
//  AppDelegate.swift
//  Ikigai
//
//  Created by Икигай on 09.06.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    AppController.shared.configureFirebase()
    return true
  }
}

