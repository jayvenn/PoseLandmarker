//
//  PoseDetector.swift
//  PoseLandmarker
//
//  Created by Jayven on 9/7/24.
//

import MediaPipeTasksVision
import AVFoundation

class PoseDetector {
  private var poseDetector: PoseLandmarker?
  private var landmarks: [NormalizedLandmark] = []
  
  init() {
    setupPoseDetector()
  }
  
  private func setupPoseDetector() {
    let modelPath = Bundle.main.path(forResource: "pose_landmarker_full", ofType: "task")
    guard let modelPath = modelPath else {
      print("Error: Could not find pose_landmarker.task in the app bundle")
      return
    }
    let options = PoseLandmarkerOptions()
    options.baseOptions.modelAssetPath = modelPath
    options.runningMode = .video
    options.numPoses = 1
    do {
      poseDetector = try PoseLandmarker(options: options)
    } catch {
      print("Failed to initialize pose detector: \(error)")
    }
  }
  
  func processVideo(url: URL, progressUpdate: @escaping (Double) -> Void) async {
    let asset = AVAsset(url: url)
    
    // Use the new asynchronous method to get the duration
    guard let duration = try? await asset.load(.duration).seconds else {
      print("Failed to load video duration")
      return
    }
    
    let fps: Float64 = 30 // Adjust as needed
    
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    
    let totalFrames = Int(duration * fps)
    var processedFrames = 0
    
    for i in stride(from: 0, to: duration, by: 1/fps) {
      let time = CMTime(seconds: i, preferredTimescale: 600)
      
      do {
        let image = try await generator.image(at: time).image
        processFrame(image: image, timestamp: i)
        
        processedFrames += 1
        let progress = Double(processedFrames) / Double(totalFrames)
        await MainActor.run {
          progressUpdate(progress)
        }
      } catch {
        print("Error generating frame: \(error)")
      }
    }
    
    await saveJSONToFile()
  }

  
  private func processFrame(image: CGImage, timestamp: Double) {
    guard
      let poseDetector = poseDetector,
      let mpImage = try? MPImage(uiImage: .init(cgImage: image)),
      let result = try? poseDetector.detect(image: mpImage),
      let poseLandmarks = result.landmarks.first else { return }
    landmarks.append(contentsOf: poseLandmarks)
  }
  
  private func saveJSONToFile() async {
    let landmarksData = landmarks.map { landmark -> [String: Any] in
      return [
        "x": landmark.x,
        "y": landmark.y,
        "z": landmark.z,
        "visibility": landmark.visibility ?? "",
        "presence": landmark.presence ?? ""
      ]
    }
    print("Landmarks Data:", landmarksData)
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: landmarksData, options: .prettyPrinted)
      print("JSON Data:", jsonData)
      let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let fileURL = documentsDirectory.appendingPathComponent("pose_landmarks.json")
      
      try jsonData.write(to: fileURL)
      print("JSON saved to: \(fileURL.path)")
    } catch {
      print("Error saving JSON: \(error)")
    }
  }
}
