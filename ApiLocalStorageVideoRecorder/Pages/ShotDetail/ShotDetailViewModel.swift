//
//  ShotDetailViewModel.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit
import AVFoundation

class ShotDetailViewModel: NSObject {
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var movieOutput: AVCaptureMovieFileOutput!
    var isRecording = false
    private let videoManager = VideoManager()
    
    weak var delegate: ShotDetailViewModelDelegate?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    func testFunc() {
        if let videoURL = videoManager.checkForExistingVideo() {
            delegate?.playVideo(videoURL)
        } else {
            delegate?.setCameraView()
        }
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access the back camera.")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        } catch {
            print("Error setting up camera input: \(error.localizedDescription)")
        }
        
        movieOutput = AVCaptureMovieFileOutput()
        captureSession.addOutput(movieOutput)
        
        captureSession.startRunning()
    }
    
    func startRecording() {
        guard let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("test.mp4") else {
            return
        }
        
        movieOutput.startRecording(to: outputFileURL, recordingDelegate: self)
        isRecording = true
    }
    
    func stopRecording() {
        movieOutput.stopRecording()
        isRecording = false
    }
    
    private func checkForExistingVideo() {
        if let videoURL = videoManager.checkForExistingVideo() {
            delegate?.playVideo(videoURL)
        } else {
            setupCamera()
        }
    }
    
    func saveVideoToDocumentsFolder(_ videoURL: URL) {
        if !videoManager.saveVideoToDocumentsFolder(videoURL) {
            print("Error saving video to documents folder.")
        }
    }
}

extension ShotDetailViewModel: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Video recording error: \(error.localizedDescription)")
            return
        }
        
        delegate?.didFinishRecording(outputFileURL)
    }
}

protocol ShotDetailViewModelDelegate: AnyObject {
    func didFinishRecording(_ videoURL: URL)
    func playVideo(_ videoURL: URL)
    func setCameraView()
}
