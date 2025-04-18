//
//  UserDefault.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
  
  let key: String
  let defaultValue: T
  
  var wrappedValue: T {
    get {
      let value = UserDefaults.standard.object(forKey: key) as? T
      switch value as Any {
      case Optional<Any>.some(let containedValue):
        return containedValue as! T
      case Optional<Any>.none:
        return defaultValue
      default:
        return value ?? defaultValue
      }
    }
    set {
      switch newValue as Any {
      case Optional<Any>.some(let containedValue):
        UserDefaults.standard.set(containedValue, forKey: key)
      case Optional<Any>.none:
        UserDefaults.standard.removeObject(forKey: key)
      default:
        UserDefaults.standard.set(newValue, forKey: key)
      }
    }
  }
}

