//
//  JSONCache.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

extension JSONCache {
  
  fileprivate static func resource<T>() -> JSONCacheResource<T>? {
    let resourceID = #function
    guard let collection = try? JSONCache.sharedCollection else {
      return nil
    }
    return JSONCacheResource(collection: collection, fileName: resourceID)
  }
}

extension JSONCache {
  
  static private var _sharedCollection: JSONCacheFolder?
  
  static var sharedCollection: JSONCacheFolder {
    get throws {
      if let existing = _sharedCollection { return existing }
      guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        throw Exception.failedToCreateRootFolder
      }
      let rootFolderURL = documentsURL.appendingPathComponent("Cache")
      return JSONCacheFolder(rootFolderURL: rootFolderURL)
    }
  }
}
