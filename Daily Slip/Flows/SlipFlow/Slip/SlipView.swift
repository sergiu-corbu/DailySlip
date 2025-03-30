//
//  SlipView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI

struct SlipView: View {
  
  @State var text = ""
  
  var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        DS.InlineHeaderView()
        
        DS.DottedBackgroundView()
          .padding(EdgeInsets(top: 10, leading: 44, bottom: 10, trailing: 44))
        
      }
      .background(Color.darkMoon)
  }
}

#Preview {
  SlipView()
}
