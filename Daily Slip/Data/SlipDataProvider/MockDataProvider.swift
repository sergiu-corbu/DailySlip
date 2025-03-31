//
//  MockDataProvider.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation

struct MockDataProvider: SlipDataProvider {
  
  let randomQuotes: [String] = [
    "The only way to do great work is to love what you do. – Steve Jobs",
    "In the end, we will remember not the words of our enemies, but the silence of our friends. – Martin Luther King Jr.",
    "Life is what happens when you're busy making other plans. – John Lennon",
    "Get busy living or get busy dying. – Stephen King",
    "You miss 100% of the shots you don’t take. – Wayne Gretzky",
    "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment. – Ralph Waldo Emerson",
    "The only limit to our realization of tomorrow is our doubts of today. – Franklin D. Roosevelt",
    "The journey of a thousand miles begins with one step. – Lao Tzu",
    "Do not go where the path may lead, go instead where there is no path and leave a trail. – Ralph Waldo Emerson",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. – Winston Churchill"
  ]
  
  func getTopics(input: String?) async throws -> [Topic] {
    try await Task.sleep(for: .seconds(1))
    return Topic.mockTopics.shuffled()
  }
  
  func generateSlipForTopic(_ topic: Topic) async throws -> String {
    ""
  }
}
