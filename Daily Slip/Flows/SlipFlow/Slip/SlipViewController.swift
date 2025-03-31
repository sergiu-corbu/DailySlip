//
//  SlipViewController.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 31.03.2025.
//

import UIKit
import SwiftUI

class SlipViewController: UIHostingController<SlipView> {
  
  let viewModel = SlipViewModel()
  
  init() {
    super.init(rootView: SlipView(viewModel: self.viewModel))
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    guard motion == .motionShake else {
      return
    }
    viewModel.handleShakeGesture()
  }
  
  @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
