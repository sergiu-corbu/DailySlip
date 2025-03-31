//
//  GeminiDataProvider.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation
import GoogleGenerativeAI

struct GeminiDataProvider: SlipDataProvider {
  
  private let topicsDataModel: GenerativeModel = {
    let schema = Schema(type: .array, items: Schema(type: .object, properties: ["topicName": Schema(type: .string)]))
    return GenerativeModel(
      name: "gemini-2.0-flash",
      apiKey: Constants.GEMINI_API_KEY,
      generationConfig: GenerationConfig(responseMIMEType: "application/json", responseSchema: schema)
    )
  }()
  private let promptBuilder = PromptBuilder()
  
  func getTopics(input: String?) async throws -> [Topic] {
    do {
      let topicsModelData = try await makeContentRequestData(
        model: topicsDataModel,
        prompt: promptBuilder.buildPromptForTopics(customTopic: input)
      )
      return try JSONDecoder().decode(Array<TopicDTO>.self, from: topicsModelData)
    } catch {
      print("Error generating content: \(error)")
      throw error
    }
  }
  
  func generateSlipForTopic(_ topic: Topic) async throws -> String {
    ""
  }
  
  private func makeContentRequestData(model: GenerativeModel, prompt: String) async throws -> Data {
    guard let jsonResponse = try await model.generateContent(prompt).text,
          let data = jsonResponse.data(using: .utf8) else {
      throw DataProviderError.missingData
    }
    return data
  }
}

fileprivate struct PromptBuilder {
  
  func buildPromptForTopics(customTopic: String?) -> String {
    let promptFormat = """
      using this JSON schema:
      Recipe = {'topicName': string}
      Return: Array<Topic>
      """
    
    if let customTopic {
      return "List some topics for quotes related to \(customTopic) " + promptFormat
    }
    return "List some topics for quotes " + promptFormat
  }
}
