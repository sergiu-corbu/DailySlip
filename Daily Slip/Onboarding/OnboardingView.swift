//
//  OnboardingView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI

struct OnboardingView: View {
  
  let onSetUp: () -> Void
  @Environment(\.fontProvider) private var fontProvider
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      DS.InlineHeaderView()
      VStack(alignment: .leading, spacing: 12) {
        Text("You are about to start a\ncuriosity-driven daily habit.")
          .foregroundStyle(.white)
          .font(fontProvider.title1)
        Rectangle()
          .fill(Color(0x545456).opacity(0.6))
          .frame(height: 1)
        onboardingVideoBoxView
      }
      .padding(EdgeInsets(top: 10, leading: 28, bottom: 28, trailing: 28))

        
      DS.Buttons.StandardButton(title: "Set Up", action: onSetUp)
        .padding(EdgeInsets(top: 32, leading: 0, bottom: 8, trailing: 0))
        .frame(maxWidth: .infinity)
    }
    .background(Color.darkMoon)
  }
  
  private var onboardingVideoBoxView: some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(Color.direWolf)
      .overlay(alignment: .top) {
        VStack(spacing: 40) {
          Text("How it works")
            .foregroundStyle(.white)
            .padding(.top, 24)
          //TODO: add video player
          RoundedRectangle(cornerRadius: 21)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 22, trailing: 16))
        }
      }
  }
}

#Preview {
  OnboardingView(onSetUp: {})
}
