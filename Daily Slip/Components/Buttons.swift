//
//  Buttons.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI

extension DesignSystem {
  struct Buttons { }
}

extension DS.Buttons {
  struct StandardButton: View {
    
    @Environment(\.fontProvider) private var fontProvider
    let title: String
    let action: () -> Void
    
    var body: some View {
      Button(action: action) {
        Text(title)
          .foregroundStyle(.white)
          .font(fontProvider.standardAction)
          .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
          .background(Color.azure, in: RoundedRectangle(cornerRadius: 40))
      }
      .buttonStyle(.plain)
    }
  }
}

#Preview {
  DS.Buttons.StandardButton(title: "Set Up", action: {})
}
