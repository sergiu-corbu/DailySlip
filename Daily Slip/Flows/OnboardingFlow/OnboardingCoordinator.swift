//
//  OnboardingCoordinator.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation
import UIKit
import SwiftUI
import Factory

class OnboardingCoordinator: Coordinator {
  
  weak private var navigationController: UINavigationController?
  let onFinishedInteraction: () -> Void
  
  @Injected(\.pushNotificationManager) private var pushNotificationManager
  
  init(navigationController: UINavigationController, onFinishedInteraction: @escaping () -> Void) {
    self.navigationController = navigationController
    self.onFinishedInteraction = onFinishedInteraction
  }
  
  func start(animated: Bool = true) {
    let onboardingView = OnboardingView(onSetUp: { [weak self] in
      self?.showWidgetSetup(animated: animated)
    })
    
    navigationController?.setViewControllers([UIHostingController(rootView: onboardingView)], animated: false)
  }
  
  private func showWidgetSetup(animated: Bool) {
    let widgetSetupView = WidgetSetupView(onFinishedInteraction: { [weak self] in
      self?.showPushNotificationPermission(animated: animated)
    })
    navigationController?.pushViewController(UIHostingController(rootView: widgetSetupView), animated: animated)
  }
  
  private func showPushNotificationPermission(animated: Bool) {
    let pushNotifPermissionView = PushNotificationPermissionView(
      pushNotificationPermissionHandler: pushNotificationManager,
      onFinishedInteraction: { [weak self] _ in
        self?.onFinishedInteraction()
      }
    )
    
    navigationController?.pushViewController(UIHostingController(rootView: pushNotifPermissionView), animated: animated)
  }
}
