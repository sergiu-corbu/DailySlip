//
//  SlipView.swift
//  Daily Slip
//
//  Created by Sergiu Corbu on 29.03.2025.
//

import SwiftUI
import Factory

struct SlipView: View {
  
  @StateObject var viewModel: SlipViewModel
  @FocusState private var isSearchFieldFocused: Bool
  @Environment(\.fontProvider) private var fontProvider
  
  var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        DS.InlineHeaderView()
        textField
        slipCanvasView
      }
      .background(Color.darkMoon)
  }
  
  private var slipCanvasView: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Your first slip")
        .foregroundStyle(.blue)
        .onTapGesture {
          viewModel.handleShakeGesture()
        }
      DS.DividerView()
      DS.DottedBackgroundView()
        .overlay(alignment: .top, content: topicsLayoutView)
        .padding(.horizontal, 20)
    }
    .padding(.horizontal, 24)
  }
  
  private var textField: some View {
    let placeholder = Text("Search Topic")
      .font(fontProvider.standardAction)
      .foregroundStyle(Color.lightGray.opacity(0.6))
    
    let textFieldStack = HStack(spacing: 4) {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(Color.lightGray.opacity(0.6))
      TextField("", text: $viewModel.searchText, prompt: placeholder)
        .focused($isSearchFieldFocused)
        .font(fontProvider.standardAction)
        .foregroundStyle(.white)
        .autocorrectionDisabled()
        .lineLimit(1)
        .submitLabel(.search)
        .onSubmit {
          viewModel.handleShakeGesture()
        }
      Spacer()
      if !viewModel.searchText.isEmpty {
        Button(action: {
          viewModel.searchText = ""
        }) {
          Image(systemName: "xmark.circle.fill")
            .foregroundStyle(.gray)
        }
        .buttonStyle(.plain)
      }
    }
    .padding(8)
    .background(Color.cement.opacity(0.24), in: .rect(cornerRadius: 10))
    
    return HStack(spacing: 16) {
      textFieldStack
      if isSearchFieldFocused {
        Button("Cancel") {
          isSearchFieldFocused = false
          viewModel.searchText = ""
        }
      }
    }
    .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
    .animation(.snappy, value: isSearchFieldFocused)
  }
  
  private func topicsLayoutView() -> some View {
    VStack(spacing: 20) {
      if viewModel.topics.isEmpty {
        Text("Shake your phone to get\nsome slip recs")
          .font(fontProvider.bigHeader)
          .foregroundStyle(.white)
          .multilineTextAlignment(.leading)
          .padding(.top, 60)
        Spacer()
      } else {
        ForEach(viewModel.topics) { topic in
          Button {
            if viewModel.selectedTopic == topic { return }
            viewModel.selectedTopic = topic
          } label: {
            TopicCellView(topic: topic)
          }
          .buttonStyle(.plain)
          .offset(x: topic.xOffset)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay {
      if viewModel.isLoading {
        ProgressView()
          .tint(.white)
      }
    }
  }
}

#Preview {
  Container.shared.slipDataProvider.register {
    MockDataProvider()
  }
  return SlipView(viewModel: SlipViewModel())
}
