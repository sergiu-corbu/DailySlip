//
//  JSONCacheCollection.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

class JSONCacheCollection<T: Codable> {
  
  let jsonFolder: JSONCacheFolder
  let indexFile: JSONCacheResource<[String]>
  
  init(rootFolderURL: URL, collectionName: String, cache: JSONCache = JSONCache.main) {
    let cacheURL = rootFolderURL.appendingPathComponent(collectionName)
    // Request collection folder has it's own cache that deallocates when the composing queue is not in use.
    self.jsonFolder = JSONCacheFolder(rootFolderURL: cacheURL, cache: cache)
    let requestListURL = cacheURL.appendingPathComponent("\(collectionName)_index.json")
    self.indexFile = JSONCacheResource(fileURL: requestListURL, cache: cache)
  }
  
  // Read
  
  func loadResource(from fileName: String) async throws -> T {
    try await jsonFolder.loadResource(of: T.self, from: fileName)
  }
  
  func loadResourceBlocking(from fileName: String) throws -> T {
    try jsonFolder.loadResourceBlocking(of: T.self, from: fileName)
  }
  
  func loadResource(at index: Int) async throws -> T? {
    let list = try await indexFile.loadResource()
    guard let fileName = list?[safe: index] else {
      return nil
    }
    let object = try await jsonFolder.loadResource(of: T.self, from: fileName)
    return object
  }
  
  func loadFileName(at index: Int) async throws -> String? {
    let list = try await indexFile.loadResource()
    guard let fileName = list?[safe: index] else {
      return nil
    }
    return fileName
  }
  
  // Multi Load
  
  func loadResources(from fileNames: [String]) async -> [T] {
    await withTaskGroup(
      of: IndexedItem<T>?.self, returning: [T].self,
      body: { taskGroup in
        for fileName in fileNames {
          taskGroup.addTask {
            if let content = try? await self.jsonFolder.loadResource(of: T.self, from: fileName) {
              return IndexedItem(index: fileName, value: content)
            } else {
              return nil
            }
          }
        }
        var results: [IndexedItem<T>] = []
        for await result in taskGroup {
          if let result = result {
            results.append(result)
          }
        }
        // Make sure to maintain the same order as the filenames
        let ordered = fileNames.compactMap { fileName in
          return results.first(where: { $0.index == fileName })?.value
        }
        return ordered
      })
  }
  
  // Write
  
  func appendToIndex(fileName: String) async throws {
    var list = try await indexFile.loadResource() ?? []
    list.append(fileName)
    try await indexFile.write(resource: list)
  }
  
  func append(resources: [(String, T)]) async throws {
    let addedFiles = SynchronizedArray<String>()
    await withTaskGroup(of: Void.self) { taskGroup in
      for resource in resources {
        taskGroup.addTask {
          do {
            try await self.jsonFolder.write(resource: resource.1, toFile: resource.0)
          } catch {
            
          }
          await addedFiles.append(resource.0)
        }
      }
      await taskGroup.waitForAll()
    }
    var list = try await indexFile.loadResource() ?? []
    let addedIndexes = await addedFiles.values
    let orderedIndexes = resources.map({ $0.0 }).filter { indexFile in
      addedIndexes.contains(where: { $0 == indexFile })
    }
    list.append(contentsOf: orderedIndexes)
    try await indexFile.write(resource: list)
  }
  
  func append(resource: T, fileName: String) async throws {
    try await jsonFolder.write(resource: resource, toFile: fileName)
    try await appendToIndex(fileName: fileName)
  }
  
  func removeFromIndex(at index: Int) async throws {
    var list = try await indexFile.loadResource() ?? []
    guard index < list.count else { return }
    list.remove(at: index)
    try await indexFile.write(resource: list)
  }
  
  @discardableResult
  func remove(file fileName: String) async throws -> [String] {
    var list = try await indexFile.loadResource() ?? []
    if let index = list.firstIndex(of: fileName) {
      list.remove(at: index)
      try jsonFolder.remove(file: fileName)
    }
    try await self.indexFile.write(resource: list)
    return list
  }
  
  // Clear
  
  func clear() async throws {
    let list = try await indexFile.loadResource() ?? []
    for file in list {
      try self.jsonFolder.remove(file: file)
    }
    try await indexFile.write(resource: [])
  }
}

fileprivate actor SynchronizedArray<T> {
  
  var values: [T] = []
  
  func append(_ value: T) {
    values.append(value)
  }
}

private struct IndexedItem<T> {
  let index: String
  let value: T
}
