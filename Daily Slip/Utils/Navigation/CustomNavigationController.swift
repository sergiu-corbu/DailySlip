//
//  CustomNavigationController.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import UIKit

class CustomNavigationController: UINavigationController {
  
  private var interactivePopRecognizer: InteractivePopRecognizer?
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    navigationBar.isHidden = true
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    navigationBar.isHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopRecognizer = InteractivePopRecognizer(controller: self)
    interactivePopGestureRecognizer?.delegate = interactivePopRecognizer
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// https://stackoverflow.com/questions/24710258/no-swipe-back-when-hiding-navigation-bar-in-uinavigationcontroller
fileprivate class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {
  
  weak var navigationController: UINavigationController?
  
  init(controller: UINavigationController) {
    self.navigationController = controller
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let navigationController else {
      return false
    }
    return navigationController.viewControllers.count > 1
  }
  
  // This is necessary because without it, subviews of your top controller can
  // cancel out your gesture recognizer on the edge.
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
