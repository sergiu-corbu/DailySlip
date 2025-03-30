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

fileprivate struct StandardButtonStyle: ButtonStyle {
  
  var tint: Color = .white
  var backgroundFill: Color = .azure
  @Environment(\.fontProvider) private var fontProvider
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundStyle(tint)
      .font(fontProvider.standardAction)
      .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
      .background(backgroundFill, in: .rect(cornerRadius: 40))
      .opacity(configuration.isPressed ? 0.8 : 1)
      .scaleEffect(configuration.isPressed ? 0.98 : 1, anchor: .top)
  }
}

extension DS.Buttons {
  struct StandardButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
      Button(action: action) {
        Text(title)
      }
      .buttonStyle(StandardButtonStyle())
    }
  }
  
  struct SecondaryButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
      Button(action: action) {
        Text(title)
      }
      .buttonStyle(StandardButtonStyle(tint: Color.azure, backgroundFill: .azure.opacity(0.15)))
    }
  }
}

#Preview {
  VStack {
    DS.Buttons.StandardButton(title: "Set Up", action: {})
    DS.Buttons.SecondaryButton(title: "Skip", action: {})
  }
  
}
