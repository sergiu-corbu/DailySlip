//
//  TopicDTO.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

typealias Topic = TopicDTO

struct TopicDTO: Decodable, Identifiable, Hashable {
  var id: String { topicName }
  let topicName: String
  let xOffset = CGFloat.random(in: -80...80)
}

extension Topic {
  static let mockTopics = [
    "Motivation", "Success", "Life", "Love", "Wisdom", "Happiness", "Courage", "Leadership",
    "Friendship", "Gratitude", "Change", "Failure", "Fear", "Peace", "Time", "Dreams", "Education",
    "Strength", "Innovation"
  ].map { TopicDTO(topicName: $0)}
}
