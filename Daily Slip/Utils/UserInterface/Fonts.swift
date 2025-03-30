//
//  Fonts.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
  
  var fontProvider: FontProvider {
    get { self[FontSystemEnvironmentKey.self] }
    set { self[FontSystemEnvironmentKey.self] = newValue }
  }
}

fileprivate struct FontSystemEnvironmentKey: EnvironmentKey {
  
  static var defaultValue: FontProvider = DefaultFontProvider.shared
}

protocol FontProvider {
  
  var header: Font { get }
  var headerLight: Font { get }
  var title1: Font { get }
  var standardAction: Font { get }
  func font(size: CGFloat, weight: Font.Weight) -> Font
}

struct DefaultFontProvider: FontProvider {
  
  static let shared = DefaultFontProvider()
  
  let header = Font.system(size: 17, weight: .semibold)
  let headerLight = Font.system(size: 17, weight: .regular)
  let title1 = Font.system(size: 22, weight: .bold)
  
  let standardAction = Font.system(size: 15, weight: .regular)
  
  func font(size: CGFloat, weight: Font.Weight) -> Font {
    Font.system(size: size, weight: weight)
  }
}
