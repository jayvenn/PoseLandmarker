//
//  ContentView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    ZStack {
      BackgroundView()
      
      VStack(spacing: 30) {
        Spacer()
        
        TitleView()
        
        VideoSelectionView(viewModel: viewModel)
        
        if let videoURL = viewModel.videoURL {
          SelectedVideoView(fileName: videoURL.lastPathComponent)
        }
        
        ProcessButtonView(viewModel: viewModel)
        
        if viewModel.isProcessing {
          ProgressView(progress: viewModel.progress)
        }
        
        Spacer()
      }
      .padding()
    }
    .fileImporter(
      isPresented: $viewModel.isShowingFilePicker,
      allowedContentTypes: [.movie],
      allowsMultipleSelection: false
    ) { result in
      viewModel.handleSelectedVideo(result)
    }
    .photosPicker(
      isPresented: $viewModel.isShowingPhotoPicker,
      selection: $viewModel.photoSelection,
      matching: .videos
    )
  }
}
