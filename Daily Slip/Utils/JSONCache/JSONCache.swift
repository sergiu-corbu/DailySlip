//
//  JSONCacheService.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

class JSONCache: @unchecked Sendable {
  
  static let main = JSONCache()
  
  private let readWriteQueue = ReadWriteQueue(label: UUID().uuidString)
  private var operationsQueues = [String: DispatchQueue]()
  
  func loadResource<T: Codable>(of type: T.Type, from filePath: String) async throws -> T {
    let queue = retrieveDispatchQueue(forID: filePath)
    return try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<T, Error>) in
      queue.async {
        do {
          let jsonData = try self.loadContentFromFile(filePath: filePath)
          let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
          continuation.resume(returning: decodedObject)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  func loadResourceBlocking<T: Codable>(of type: T.Type, from filePath: String) throws -> T {
    let queue = retrieveDispatchQueue(forID: filePath)
    var decodedObject: T!
    try queue.sync {
      let jsonData = try self.loadContentFromFile(filePath: filePath)
      decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
    }
    return decodedObject
  }
  
  func write<T: Codable>(resource: T, to filePath: String) async throws {
    let queue = retrieveDispatchQueue(forID: filePath)
    return try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<Void, Error>) in
      queue.async(flags: .barrier) {
        do {
          let jsonData = try JSONEncoder().encode(resource)
          try self.save(data: jsonData, to: filePath)
          continuation.resume()
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  func removeResource(at filePath: String) throws {
    let queue = retrieveDispatchQueue(forID: filePath)
    try queue.sync(flags: .barrier) {
      try FileManager.default.removeItem(atPath: filePath as String)
    }
  }
  
  private func save(data: Data, to filePath: String) throws {
    // Create directory if necessary
    let fileManager = FileManager.default
    let filePath = filePath as NSString
    if fileManager.fileExists(atPath: filePath.deletingLastPathComponent) == false {
      // marked as try? because because of possible race condition. There can be multiple request in parallel for creating directory, and some of them might fail.
      try? fileManager.createDirectory(
        atPath: filePath.deletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
    }
    try data.write(to: URL(fileURLWithPath: filePath as String))
  }
  
  private func loadContentFromFile(filePath: String) throws -> Data {
    guard FileManager.default.fileExists(atPath: filePath) else {
      throw Exception.fileNotFound
    }
    guard FileManager.default.isReadableFile(atPath: filePath) else {
      throw Exception.fileNotReadable
    }
    return try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
  }
  
  private func retrieveDispatchQueue(forID id: String) -> DispatchQueue {
    var _queue: DispatchQueue!
    readWriteQueue.write {
      if let queue = operationsQueues[id] {
        _queue = queue
      }
      let queue = DispatchQueue(label: id, attributes: .concurrent)
      operationsQueues[id] = queue
      _queue = queue
    }
    return _queue
  }
}

extension JSONCache {
  
  enum Exception: LocalizedError {
    
    case fileNotFound
    case fileNotReadable
    case fileNotWritable
    case failedToCreateRootFolder
    
    var errorDescription: String? {
      switch self {
      case .fileNotFound:
        return "\(String(reflecting:self)): File not found at specified path."
      case .fileNotReadable:
        return "\(String(reflecting:self)): File at specified path cannot be read."
      case .fileNotWritable:
        return "\(String(reflecting:self)): File at specified path cannot be written."
      case .failedToCreateRootFolder:
        return "\(String(reflecting:self)): Failed to create root cache folder"
      }
    }
  }
}

fileprivate class ReadWriteQueue {
  
  let concurentQueue: DispatchQueue
  
  init(label: String, isConcurrent: Bool = true) {
    if isConcurrent {
      self.concurentQueue = DispatchQueue(label: label, attributes: .concurrent)
    } else {
      self.concurentQueue = DispatchQueue(label: label)
    }
  }
  
  func read(closure: () -> Void) {
    self.concurentQueue.sync {
      closure()
    }
  }
  
  func readValue<T>(closure: () -> T) -> T {
    var value: T!
    self.concurentQueue.sync {
      value = closure()
    }
    return value
  }
  
  func write(closure: () -> Void) {
    self.concurentQueue.sync(
      flags: .barrier,
      execute: {
        closure()
      })
  }
}

