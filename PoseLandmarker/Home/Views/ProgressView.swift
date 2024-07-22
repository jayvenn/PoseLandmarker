//
//  ProgressView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct ProgressView: View {
  let progress: Double
  
  var body: some View {
    VStack {
      SwiftUI.ProgressView(value: progress, total: 1.0)
        .progressViewStyle(LinearProgressViewStyle(tint: .white))
      Text("\(Int(progress * 100))%")
        .font(.system(size: 14, design: .rounded))
        .foregroundColor(.white)
    }
    .padding()
    .background(Color.black.opacity(0.2))
    .cornerRadius(10)
  }
}

