//
//  RootCoordinator.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {
  
  //MARK: - Coordinators
  //  var mainCoordinator: MainCoordinator?
  var onboardingCoordinator: OnboardingCoordinator?
  
  //MARK: - Properties
  weak var window: UIWindow?
  private let navigationController = CustomNavigationController()
  
  @UserDefault(key: Constants.didShowOnboarding, defaultValue: false)
  var didShowOnboarding: Bool
  
  init(window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    self.window = window
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func start(animated: Bool) {
    if didShowOnboarding {
      showMainFlow()
    } else {
      showOnboardingFlow()
    }
  }
  
  func showMainFlow() {
    
  }
  
  func showOnboardingFlow() {
    onboardingCoordinator = OnboardingCoordinator(
      navigationController: navigationController,
      onFinishedInteraction: { [weak self] in
        self?.handleOnboardingInteractionFinished()
      }
    )
    onboardingCoordinator?.start()
  }
  
  private func handleOnboardingInteractionFinished() {
    didShowOnboarding = true
    onboardingCoordinator = nil
    showMainFlow()
  }
}

extension RootCoordinator {
  struct Constants {
    static let didShowOnboarding = "didShowOnboarding"
  }
}
