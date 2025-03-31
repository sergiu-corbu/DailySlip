//
//  SlipDataProvider.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation

protocol SlipDataProvider {
  
  func generateSlipForTopic(_ topic: Topic) async throws -> String
  func getTopics(input: String?) async throws -> [Topic]
}
