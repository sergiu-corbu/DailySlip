//
//  OnboardingCoordinator.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation
import UIKit
import SwiftUI

class OnboardingCoordinator: Coordinator {
  
  weak private var navigationController: UINavigationController?
  let onFinishedInteraction: () -> Void
  
  init(navigationController: UINavigationController, onFinishedInteraction: @escaping () -> Void) {
    self.navigationController = navigationController
    self.onFinishedInteraction = onFinishedInteraction
  }
  
  func start(animated: Bool = true) {
    let onboardingView = OnboardingView(onSetUp: { [weak self] in
      self?.onFinishedInteraction()
    })
    
    navigationController?.setViewControllers([UIHostingController(rootView: onboardingView)], animated: false)
  }
}
