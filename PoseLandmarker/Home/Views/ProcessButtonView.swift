//
//  ProcessButtonView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct ProcessButtonView: View {
  @ObservedObject var viewModel: ContentViewModel
  
  var body: some View {
    Button(action: viewModel.processVideo) {
      Text("Process Video")
        .font(.system(size: 18, weight: .semibold, design: .rounded))
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(viewModel.videoURL == nil || viewModel.isProcessing ? Color.gray : Color.green)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    .disabled(viewModel.videoURL == nil || viewModel.isProcessing)
  }
}
