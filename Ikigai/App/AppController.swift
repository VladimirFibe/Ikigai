//
//  AppController.swift
//  Ikigai
//
//  Created by Икигай on 09.06.2022.
//

import UIKit
import Firebase

final class AppController {
  static let shared = AppController()
  private var window: UIWindow!
  private var rootViewController: UIViewController? {
    didSet {
      window.rootViewController = rootViewController
    }
  }
  
  init() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(handleAppState),
      name: .AuthStateDidChange,
      object: nil)
  }
  
  func configureFirebase() {
    FirebaseApp.configure()
  }
  
  func show(in window: UIWindow?) {
    guard let window = window else {
      fatalError("Cannot layout app with a nil window")
    }
    self.window = window
    window.backgroundColor = .red
    handleAppState()
    window.makeKeyAndVisible()
  }
  @objc private func handleAppState() {
    if let user = Auth.auth().currentUser {
      print("вошел")
      rootViewController = NavigationController(ViewController())
    } else {
      rootViewController = LoginViewController()
    }
  }
}
