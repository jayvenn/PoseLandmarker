//
//  ContentViewModel.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI
import PhotosUI

class ContentViewModel: ObservableObject {
  @Published var isShowingFilePicker = false
  @Published var isShowingPhotoPicker = false
  @Published var videoURL: URL?
  @Published var isProcessing = false
  @Published var progress: Double = 0
  @Published var photoSelection: PhotosPickerItem? = nil {
    didSet {
      if let photoSelection {
        handlePhotoPickerResult(photoSelection)
      }
    }
  }
  
  private let poseDetector = PoseDetector()
  
  func processVideo() {
    guard let url = videoURL else { return }
    
    isProcessing = true
    progress = 0
    
    Task {
      await poseDetector.processVideo(url: url) { currentProgress in
        DispatchQueue.main.async {
          self.progress = currentProgress
        }
      }
      
      await MainActor.run {
        self.isProcessing = false
        self.progress = 0
      }
    }
  }

  
  func handleSelectedVideo(_ result: Result<[URL], Error>) {
    switch result {
    case .success(let files):
      if let file = files.first {
        videoURL = file
      }
    case .failure(let error):
      print("Error selecting file: \(error.localizedDescription)")
    }
  }
  
  func handlePhotoPickerResult(_ item: PhotosPickerItem) {
    Task {
      guard let data = try? await item.loadTransferable(type: Data.self) else { return }
      let tempURL = FileManager.default.temporaryDirectory
        .appendingPathComponent(UUID().uuidString)
        .appendingPathExtension("mov")
      try? data.write(to: tempURL)
      await MainActor.run {
        self.videoURL = tempURL
      }
    }
  }
}
