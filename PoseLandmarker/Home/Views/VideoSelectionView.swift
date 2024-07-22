//
//  VideoSelectionView.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import SwiftUI

struct VideoSelectionView: View {
  @ObservedObject var viewModel: ContentViewModel
  
  var body: some View {
    HStack(spacing: 20) {
      SelectButton(title: "Files", icon: "doc.fill") {
        viewModel.isShowingFilePicker = true
      }
      SelectButton(title: "Photos", icon: "photo.fill") {
        viewModel.isShowingPhotoPicker = true
      }
    }
  }
}
