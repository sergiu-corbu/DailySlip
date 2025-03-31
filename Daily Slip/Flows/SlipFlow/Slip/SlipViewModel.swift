//
//  SlipViewModel.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 30.03.2025.
//

import Foundation
import Factory

class SlipViewModel: ObservableObject {
  
  @Published var searchText: String = ""
  @Published private(set) var topics = [Topic]()
  @Published var selectedTopic: Topic?
  @Published var isLoading = false
  
  @Injected(\.slipDataProvider) private var slipDataProvider
  
  private var slipDataTask: Task<Void, Never>?
  
  func handleShakeGesture() {
    slipDataTask?.cancel()
    slipDataTask = Task(priority: .userInitiated) { @MainActor [weak self] in
      guard let self else { return }
      do {
        isLoading = true
        self.topics = try await slipDataProvider.getTopics(input: searchText.isEmpty ? nil : searchText)
      } catch {
        print(error.localizedDescription)
      }
      isLoading = false
    }
  }
}
