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
        DS.DividerView()
        onboardingVideoBoxView
      }
      .padding(EdgeInsets(top: 10, leading: 28, bottom: 28, trailing: 28))

        
      DS.Buttons.StandardButton(title: "Set Up", action: onSetUp)
        .padding(.top, 32)
        .safeAreaPadding(.bottom, 8)
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
