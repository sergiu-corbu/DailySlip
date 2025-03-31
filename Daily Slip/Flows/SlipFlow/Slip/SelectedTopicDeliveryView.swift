//
//  SelectedTopicDeliveryView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 31.03.2025.
//

import SwiftUI

struct SelectedTopicDeliveryView: View {
  
  let topic: Topic
  
  @Environment(\.fontProvider) private var fontProvider
  @State private var showDatePicker = true
  
  var body: some View {
    VStack(spacing: 10) {
      DS.DottedBackgroundView()
        .overlay {
          Text(topic.topicName)
            .font(fontProvider.headerLight)
            .foregroundStyle(.white)
            .lineLimit(1)
            .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
            .background(Color(0x1B1B1B))
            .border(Color(0x7F7F7F), width: 1)
        }
      Image(systemName: "arrow.down")
        .foregroundStyle(.white)
      DS.DottedBackgroundView()
        .overlay(alignment: .topLeading) {
          Text("Set up the time for your\ndaily slip")
            .foregroundStyle(.white)
            .font(fontProvider.bigHeader)
            .padding(EdgeInsets(top: 14, leading: 20, bottom: 0, trailing: 20))
        }
    }
    .overlay(alignment: .bottom) {
      if showDatePicker {
        VStack {
          Text("Every day at")
          DatePicker("", selection: .constant(.now), displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(.wheel)
            .colorScheme(.dark)
            
            }
        .background(Color.richGray)
      }
    }
  }
}



#Preview {
  SelectedTopicDeliveryView(topic: Topic.mockTopics.randomElement()!)
    .background(Color.darkMoon)
}
