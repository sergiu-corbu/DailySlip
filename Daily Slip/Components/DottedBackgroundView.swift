//
//  DottedBackgroundView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI

extension DS {
  struct DottedBackgroundView: View {
    
    var tint: Color = .ghostWhite.opacity(0.2)
    var spacing: CGFloat = 10
    var circleDiameter: CGFloat = 3
    
    var body: some View {
      GeometryReader { proxy in
        let dottedRow = dottedRowView(in: proxy.size.width)
        let rowsCount = Int(proxy.size.height / (circleDiameter + spacing))
        VStack(alignment: .center, spacing: spacing) {
          ForEach(0...rowsCount, id: \.self) { _ in
            dottedRow
          }
        }
        .compositingGroup()
        .frame(maxWidth: .infinity)
      }
    }
    
    private func dottedRowView(in width: CGFloat) -> some View {
      HStack(spacing: spacing) {
        ForEach(0..<Int(width / (circleDiameter + spacing)), id: \.self) { _ in
          Circle()
            .fill(tint)
            .frame(width: circleDiameter, height: circleDiameter)
        }
      }
    }
  }
}

#Preview {
  Color.darkMoon.ignoresSafeArea()
    .overlay(
      DS.DottedBackgroundView()
    )
}
