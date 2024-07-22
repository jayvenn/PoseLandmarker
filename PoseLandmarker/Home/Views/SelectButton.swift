//
//  SelectButton.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct SelectButton: View {
  let title: String
  let icon: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      VStack {
        Image(systemName: icon)
          .font(.system(size: 30))
        Text(title)
          .font(.system(size: 14, weight: .medium, design: .rounded))
      }
      .foregroundColor(.white)
      .frame(width: 100, height: 100)
      .background(Color.white.opacity(0.2))
      .cornerRadius(20)
      .shadow(radius: 5)
    }
  }
}
