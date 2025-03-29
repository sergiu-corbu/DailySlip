//
//  Collection+Extensions.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
  
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
  
  var enumeratedArray: Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}
