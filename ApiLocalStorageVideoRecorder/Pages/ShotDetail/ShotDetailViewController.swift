//
//  ShotDetailViewController.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit
import AVFoundation

class ShotDetailViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    
    private var viewModel: ShotDetailViewModel!
    private var player: AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ShotDetailViewModel()
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewModel.videoPreviewLayer.frame = cameraView.bounds
        cameraView.layer.addSublayer(viewModel.videoPreviewLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        viewModel.testFunc()
    }
    
    
    private func setupCamera() {
        viewModel.startRecording()
    }
    
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if viewModel.isRecording {
            viewModel.stopRecording()
        } else {
            viewModel.startRecording()
        }
    }
    
}

extension ShotDetailViewController: ShotDetailViewModelDelegate {
    func setCameraView() {
        
    }
    
    func playVideo(_ videoURL: URL) {
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = cameraView.bounds
        
        cameraView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        cameraView.layer.addSublayer(playerLayer)
        
        player?.play()
        
    }
    
    func didFinishRecording(_ videoURL: URL) {
        viewModel.saveVideoToDocumentsFolder(videoURL)
        playVideo(videoURL)
    }
    
    
}
