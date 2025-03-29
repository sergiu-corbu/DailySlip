//
//  GenerativeAIProvider.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation

protocol GenerativeAIProvider {
  
  func generateTextFromInput(_ input: String) async throws -> String
}
