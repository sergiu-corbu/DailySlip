//
//  PushNotificationManager.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 30.03.2025.
//

import UIKit
import Combine
import UserNotifications

protocol PushNotificationsPermissionHandler {
  
  func shouldRequestPermission() async -> Bool
  func getCurrentAuthorizationStatus() async -> UNAuthorizationStatus
  func requestPushNotificationsPermission() async throws -> Bool
}

class PushNotificationsManager: NSObject {
    
  //MARK: - Getters
  var pushNotificationsEnabled: Bool {
    get async {
      return await getCurrentAuthorizationStatus() == .authorized
    }
  }
  
  //MARK: - Services
  private let notificationCenter: UNUserNotificationCenter = .current()
  
  override init() {
    super.init()
    
    Task(priority: .utility) { @MainActor in
      if await pushNotificationsEnabled {
        configurePushNotificationsService()
      }
    }
  }
  
  //MARK: - Setup
  func configurePushNotificationsService() {
    notificationCenter.delegate = self
  }
  
  func unregisterForPushNotifications() {
    notificationCenter.removeAllDeliveredNotifications()
    notificationCenter.removeAllPendingNotificationRequests()
    updateNotificationsBadgeCount(0)
    
    UIApplication.shared.unregisterForRemoteNotifications()
  }
  
  func updateNotificationsBadgeCount(_ newValue: Int) {
    notificationCenter.setBadgeCount(newValue)
  }
}

//MARK: UNUserNotificationCenterDelegate
extension PushNotificationsManager: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//    guard let userInfo = response.notification.userInfoData else {
//      completionHandler()
//      return
//    }
//    
//    Task(priority: .userInitiated) {
//      await processPushNotification(data: userInfo)
//      await MainActor.run {
//        completionHandler()
//      }
//    }
  }
}

//MARK: - PushNotification processing
//extension PushNotificationsManager {
//  
//  private func processPushNotification(
//    data userInfo: [String : Any],
//    shouldPerformAction: (PushNotificationType) -> Bool = { _ in true}
//  ) async {
//    
//    let objectID = userInfo["objectId"] as? String
//    let notificationTypeString = userInfo["event"] as? String
//    
//    guard let notificationTypeString, let objectID,
//          let notificationType = PushNotificationType(rawValue: notificationTypeString),
//          shouldPerformAction(notificationType) else {
//      return
//    }
//    
//    await pushNotificationsInteractor.processPushNotification(type: notificationType, objectID: objectID)
//  }
//  
//  func processPushNotification(options launchOptions: [UIApplication.LaunchOptionsKey: Any]) {
//    guard let data = launchOptions[.remoteNotification] as? [String : Any],
//          let pushNotificationData = data["data"] as? [String:Any] else {
//      return
//    }
//    
//    Task(priority: .userInitiated) {
//      await self.processPushNotification(data: pushNotificationData)
//    }
//  }
//}

//MARK: PushNotificationHandler
extension PushNotificationsManager: PushNotificationsPermissionHandler {
  
  func getCurrentAuthorizationStatus() async -> UNAuthorizationStatus {
    return await notificationCenter.notificationSettings().authorizationStatus
  }
  
  func shouldRequestPermission() async -> Bool {
    let currentNotificationsSettings = await notificationCenter.notificationSettings()
    return [.denied, .notDetermined].contains(currentNotificationsSettings.authorizationStatus)
  }
  
  /// a methd that displays the standard request alert for notifications
  @MainActor func requestPushNotificationsPermission() async throws -> Bool {
    let isAuthorized = try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    if isAuthorized {
      UIApplication.shared.registerForRemoteNotifications()
    }
    
    configurePushNotificationsService()
    return isAuthorized
  }
}

#if DEBUG
struct MockPushNotificationsHandler: PushNotificationsPermissionHandler {
  
  func shouldRequestPermission() async -> Bool {
    return true
  }
  
  func getCurrentAuthorizationStatus() async -> UNAuthorizationStatus {
    return .notDetermined
  }
  
  func requestPushNotificationsPermission() async throws -> Bool {
    return Bool.random()
  }
  
  var pushNotificationsTokenPublisher: CurrentValueSubject<String?, Never> = .init(nil)
}
#endif
