//
//  InlineHeaderView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI

typealias DS = DesignSystem
struct DesignSystem {
  
}

extension DesignSystem {
  
  struct InlineHeaderView: View {
    
    var title: String = "Slip"
    @Environment(\.fontProvider) private var fontProvider
    
    var body: some View {
      Text(title)
        .font(fontProvider.header)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, minHeight: 44)
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  DS.InlineHeaderView()
    .padding()
    .background(Color.darkMoon)
}
