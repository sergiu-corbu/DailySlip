//
//  JSONCachedFile.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

class JSONCacheResource<T: Codable> {
  
  let cache: JSONCache
  let fileURL: URL
  
  private let fileExtension = "json"
  
  init(fileURL: URL, cache: JSONCache = JSONCache.main) {
    self.cache = cache
    self.fileURL = fileURL
  }
  
  init(collection: JSONCacheFolder, fileName: String, appendFileExtension: Bool = true) {
    self.cache = collection.cache
    var fileURL = collection.rootFolderURL.appendingPathComponent(fileName)
    if appendFileExtension {
      fileURL = fileURL.appendingPathExtension(fileExtension)
    }
    self.fileURL = fileURL
  }
  
  static func createInSharedCollection(fileName: String, appendFileExtension: Bool = true) -> JSONCacheResource {
    do {
      let sharedCollection = try JSONCache.sharedCollection
      return JSONCacheResource(collection: sharedCollection, fileName: fileName)
    } catch {
      debugPrint(error)
      return JSONCacheResource(fileURL: URL(fileURLWithPath: "INVALID_CACHE"))
    }
  }
  
  func loadResource() async throws -> T? {
    guard FileManager.default.fileExists(atPath: fileURL.path) else {
      return nil
    }
    return try await cache.loadResource(of: T.self, from: fileURL.path)
  }
  
  func loadResourceBlocking() throws -> T? {
    guard FileManager.default.fileExists(atPath: fileURL.path) else {
      return nil
    }
    return try cache.loadResourceBlocking(of: T.self, from: fileURL.path)
  }
  
  func write(resource: T) async throws {
    return try await cache.write(resource: resource, to: fileURL.path)
  }
  
  func remove() throws {
    try cache.removeResource(at: fileURL.path)
  }
}

class MockedJSONCacheResource<T: Codable>: JSONCacheResource<T> {
  
  let mocked: T
  
  init(mocked: T) {
    self.mocked = mocked
    super.init(fileURL: URL(fileURLWithPath: "INVALID_CACHE"))
  }
  
  override func loadResource() async throws -> T? {
    return mocked
  }
  
  override func loadResourceBlocking() throws -> T? {
    return mocked
  }
  
  override func write(resource: T) async throws {
    print("Warning (MockedJSONCacheResource) : Writing to a mocked instantce.")
  }
  
  override func remove() throws {
    print("Warning (MockedJSONCacheResource) : Removing from a mocked instantce.")
  }
}
