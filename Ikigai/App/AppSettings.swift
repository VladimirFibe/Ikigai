//
//  AppSettings.swift
//  Ikigai
//
//  Created by Икигай on 09.06.2022.
//

import Foundation

enum AppSettings {
  static private let displayNameKey = "DisplayName"
  static var displayName: String {
    get  {
      UserDefaults.standard.string(forKey: displayNameKey) ?? "Xcode"
    }
    set {
      UserDefaults.standard.set(newValue, forKey: displayNameKey)
    }
  }
}
