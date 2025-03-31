//
//  SlipCoordinator.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 30.03.2025.
//

import Foundation
import UIKit

class SlipCoordinator: Coordinator {
  
  weak private var navigationController: UINavigationController?
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start(animated: Bool) {
    navigationController?.setViewControllers([SlipViewController()], animated: false)
  }
}
