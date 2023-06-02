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
    @IBOutlet weak var shotDataView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    var viewModel: ShotDetailViewModel!
    private var player: AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setWaterView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.videoPreviewLayer.frame = cameraView.bounds
        cameraView.layer.addSublayer(viewModel.videoPreviewLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { [self] in
            viewModel.checkForExistingVideo()
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if viewModel.isRecording {
            viewModel.stopRecording()
        } else {
            shotDataView.isHidden = true
            viewModel.startRecording()
        }
    }
    
     func setWaterView() {
        if let shot = viewModel.setShotData() {
            lbl1.text = String(shot.InOut)
            lbl2.text = String(shot.point)
            lbl3.text = String(shot.segment)
        }
        
        
    }
}

extension ShotDetailViewController: ShotDetailViewModelDelegate {
    func playVideo(_ videoURL: URL) {
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = cameraView.bounds
        
        cameraView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        cameraView.layer.addSublayer(playerLayer)
        
        player?.play()
        shotDataView.isHidden = false
        
    }
    
    func didFinishRecording(_ videoURL: URL) {
        viewModel.saveVideoToDocumentsFolder(videoURL)
        playVideo(videoURL)
    }
    
    
}
