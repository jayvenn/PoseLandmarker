//
//  VideoPlayerWithLandmarks.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

//import SwiftUI
//import AVKit
//
//struct VideoPlayerWithLandmarks: View {
//  let videoURL: URL
//  let landmarks: [PoseLandmark]
//  @State private var currentTime: CMTime = .zero
//  @State private var player: AVPlayer?
//  
//  var body: some View {
//    ZStack {
//      VideoPlayer(player: player)
//        .onAppear {
//          player = AVPlayer(url: videoURL)
//        }
//      
//      LandmarksOverlay(landmarks: landmarks, currentTime: currentTime)
//    }
//    .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
//      if let player = player {
//        currentTime = player.currentTime()
//      }
//    }
//  }
//}
//
//struct LandmarksOverlay: View {
//  let landmarks: [PoseLandmark]
//  let currentTime: CMTime
//  
//  var body: some View {
//    GeometryReader { geometry in
//      ForEach(currentLandmarks, id: \.self) { landmark in
//        Circle()
//          .fill(Color.red)
//          .frame(width: 10, height: 10)
//          .position(
//            x: landmark.position.x * geometry.size.width,
//            y: landmark.position.y * geometry.size.height
//          )
//      }
//    }
//  }
//  
//  var currentLandmarks: [PoseLandmark] {
//    landmarks.filter { $0.timestamp == Float(currentTime.seconds) }
//  }
//}
//
//struct PoseLandmark: Hashable {
//  let position: CGPoint
//  let timestamp: Float
//}
