//
//  BackgroundView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct BackgroundView: View {
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.4)]),
                   startPoint: .topLeading, endPoint: .bottomTrailing)
    .edgesIgnoringSafeArea(.all)
  }
}
