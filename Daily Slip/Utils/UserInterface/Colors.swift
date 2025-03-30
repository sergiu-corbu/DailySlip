//
//  Colors.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import SwiftUI

extension Color {
  
  static let deepGray = Color(0x454545)
  static let direWolf = Color(0x282829)
  static let azure = Color(0x0A84FF)
  static let ghostWhite = Color(0xF8F9FC)
}

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: alpha
    )
  }
}

