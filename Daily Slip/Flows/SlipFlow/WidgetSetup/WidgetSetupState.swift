//
//  WidgetSetupState.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 08.04.2025.
//

import Foundation

enum WidgetSetupState: Int, CaseIterable, Hashable {
  case step1, step2, step3, step4, step5
  
  var title: String {
    switch self {
    case .step1: "Press and hold anywhere on the Home Screen"
    case .step2: "Tap Edit on the left corner of the Home Screen"
    case .step3: "Choose `Add Widget`"
    case .step4: "Search Slip Widget"
    case .step5: "Choose Widget Size and press the `Add Widget` Button"
    }
  }
  
  var imageResourceName: String {
    "widget_setup_step\(rawValue + 1)"
  }
}
