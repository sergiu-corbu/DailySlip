//
//  PushNotificationPermissionView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 30.03.2025.
//

import SwiftUI

struct PushNotificationPermissionView: View {
  
  let pushNotificationPermissionHandler: PushNotificationsPermissionHandler
  let onFinishedInteraction: (_ didAllowNotifications: Bool) -> Void
  @Environment(\.fontProvider) private var fontProvider
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      DS.InlineHeaderView()
      Text("Turn on notifications")
        .font(fontProvider.headerLight)
        .foregroundStyle(.white)
      DS.DividerView()
      Text("Don't miss the time your slip is ready.")
        .font(fontProvider.title1)
        .foregroundStyle(.white)
      slipAbstractBoxView
      footerSectionView
    }
    .padding(.horizontal, 28)
    .background(Color.darkMoon)
  }
  
  private var slipAbstractBoxView: some View {
    return RoundedRectangle(cornerRadius: 10)
      .fill(Color.direWolf.opacity(0.12))
      .padding(.top, 24)
      .overlay(Image(.notificationAbstarct))
  }
  
  private var footerSectionView: some View {
    HStack(spacing: 0) {
      DS.Buttons.SecondaryButton(title: "Skip") {
        onFinishedInteraction(false)
      }
      Spacer()
      DS.Buttons.StandardButton(title: "Yes, notify me") {
        handlePushNotificationPresentation()
      }
    }
    .safeAreaPadding(.bottom, 28)
  }
  
  func handlePushNotificationPresentation() {
    Task(priority: .userInitiated) {
      guard await pushNotificationPermissionHandler.shouldRequestPermission() else {
        return
      }
      let isAllowed = try await pushNotificationPermissionHandler.requestPushNotificationsPermission()
      onFinishedInteraction(isAllowed)
    }
  }
}

#Preview {
  PushNotificationPermissionView(
    pushNotificationPermissionHandler: MockPushNotificationsHandler(),
    onFinishedInteraction: {_ in}
  )
}
