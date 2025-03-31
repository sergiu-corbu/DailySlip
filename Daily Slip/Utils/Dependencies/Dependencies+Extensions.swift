//
//  Dependencies+Extensions.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 30.03.2025.
//

import Foundation
import Factory

extension Container {
  
  var pushNotificationManager: Factory<PushNotificationsManager> {
    Factory(self) { PushNotificationsManager() }
  }
  
  var slipDataProvider: Factory<SlipDataProvider> {
    Factory(self) { GeminiDataProvider() }
  }
}
