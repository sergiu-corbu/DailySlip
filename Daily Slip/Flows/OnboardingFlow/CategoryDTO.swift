//
//  CategoryDTO.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

struct CategoryDTO: Identifiable {
  var id: String { name.appending("_id") }
  let name: String
  
  let mockCategories = [
      "Motivation", "Success", "Life", "Love", "Wisdom", "Happiness", "Courage", "Leadership",
      "Friendship", "Gratitude", "Change", "Failure", "Fear", "Peace", "Time", "Dreams", "Education",
      "Strength", "Innovation"
  ].map { CategoryDTO(name: $0)}
}
