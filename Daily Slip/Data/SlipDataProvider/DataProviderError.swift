//
//  DataProviderError.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 28.03.2025.
//

import Foundation

enum DataProviderError: LocalizedError {
  
  case missingData
  
  var errorDescription: String? {
    switch self {
    case .missingData: "No text was found in the response"
      
    }
  }
}
