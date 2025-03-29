//
//  JSONCacheFolder.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

class JSONCacheFolder {
  
  let cache: JSONCache
  let rootFolderURL: URL
  let appendExtension: Bool
  
  private let fileExtension = "json"
  
  init(rootFolderURL: URL, cache: JSONCache = JSONCache.main, appendExtension: Bool = true) {
    self.cache = cache
    self.rootFolderURL = rootFolderURL
    self.appendExtension = appendExtension
    var isDirectory: ObjCBool = true
    if !FileManager.default.fileExists(atPath: rootFolderURL.path, isDirectory: &isDirectory) {
      try? FileManager.default.createDirectory(at: rootFolderURL, withIntermediateDirectories: true)
    }
  }
  
  func loadResource<T: Codable>(of type: T.Type, from fileName: String) async throws -> T {
    let url = url(for: fileName)
    return try await cache.loadResource(of: type, from: url.path)
  }
  
  func loadResourceBlocking<T: Codable>(of type: T.Type, from fileName: String) throws -> T {
    let url = url(for: fileName)
    return try cache.loadResourceBlocking(of: type, from: url.path)
  }
  
  func write<T: Codable>(resource: T, toFile fileName: String) async throws {
    let url = url(for: fileName)
    return try await cache.write(resource: resource, to: url.path)
  }
  
  func remove(file fileName: String) throws {
    let url = url(for: fileName)
    try cache.removeResource(at: url.path)
  }
  
  private func url(for fileName: String) -> URL {
    var url = rootFolderURL.appendingPathComponent(fileName)
    if appendExtension {
      url = url.appendingPathExtension(fileExtension)
    }
    return url
  }
}
