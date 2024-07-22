//
//  SelectedVideoView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct SelectedVideoView: View {
  let fileName: String
  
  var body: some View {
    Text(fileName)
      .font(.system(size: 16, design: .rounded))
      .foregroundColor(.white)
      .padding()
      .background(Color.white.opacity(0.2))
      .cornerRadius(10)
  }
}
