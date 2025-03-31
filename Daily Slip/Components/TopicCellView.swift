//
//  TopicCellView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 31.03.2025.
//

import SwiftUI

struct TopicCellView: View {
  
  let topic: Topic
  @Environment(\.fontProvider) private var fontProvider
  
  var body: some View {
    Text(topic.topicName)
      .font(fontProvider.headerLight)
      .foregroundStyle(.white)
      .lineLimit(1)
      .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
      .background(Color.cement.opacity(0.24), in: .rect(cornerRadius: 6))
      .contentShape(.rect)
  }
}

#Preview {
  VStack {
    TopicCellView(topic: Topic.mockTopics.randomElement()!)
    TopicCellView(topic: Topic.mockTopics.randomElement()!)
  }
  .padding()
  .background(Color.deepGray)
}
