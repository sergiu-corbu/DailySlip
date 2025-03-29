//
//  GeminiDataProvider.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation
import GoogleGenerativeAI

struct GeminiDataProvider: GenerativeAIProvider {
  
  func generateTextFromInput(_ input: String) async throws -> String {
    let model = GenerativeModel(name: "gemini-pro", apiKey: Constants.GEMINI_API_KEY)
    do {
      guard let textResponse = try await model.generateContent(input).text else {
        throw DataProviderError.missingText
      }
      return textResponse
    } catch {
      print("Error generating content: \(error)")
      throw error
    }
  }
}
