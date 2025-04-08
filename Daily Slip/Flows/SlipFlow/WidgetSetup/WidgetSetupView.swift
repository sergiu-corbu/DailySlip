//
//  WidgetSetupView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 08.04.2025.
//

import SwiftUI

struct WidgetSetupView: View {
  
  @State private var step: WidgetSetupState = .step1
  @Environment(\.fontProvider) private var fontProvider
  
  let onFinishedInteraction: () -> Void
  
  private var mainButtonTitle: String {
    step == WidgetSetupState.allCases.last ? "Done" : "Next"
  }
  
  var body: some View {
    VStack(spacing: 44) {
      headerView
      stepView(self.step)
      DS.Buttons.StandardButton(title: mainButtonTitle, action: handleMainButtonAction)
    }
    .padding(EdgeInsets(top: 0, leading: 28, bottom: 8, trailing: 28))
    .background(Color.darkMoon)
  }
  
  var headerView: some View {
    VStack(spacing: 10) {
      DS.InlineHeaderView()
      HStack(spacing: 4) {
        Text("Widget Setup")
          .font(fontProvider.header)
        Text("\(step.rawValue + 1)/\(WidgetSetupState.allCases.count)")
          .font(fontProvider.headerLight)
        Spacer()
      }
      .foregroundStyle(.white)
      DS.DividerView()
    }
  }
  
  func stepView(_ step: WidgetSetupState) -> some View {
    VStack(spacing: 44) {
      Text(step.title)
        .foregroundStyle(.white)
        .font(fontProvider.title1)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
      GeometryReader { proxy in
        Image(step.imageResourceName)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: proxy.size.width, height: proxy.size.height)
      }
    }
    .animation(.snappy, value: step)
  }
  
  func handleMainButtonAction() {
    guard step != WidgetSetupState.allCases.last else {
      onFinishedInteraction()
      return
    }
    step = WidgetSetupState(rawValue: step.rawValue + 1) ?? .step1
  }
}

#Preview {
  WidgetSetupView(onFinishedInteraction: {})
}
