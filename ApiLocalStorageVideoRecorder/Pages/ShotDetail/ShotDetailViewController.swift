//
//  ShotDetailViewController.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import UIKit
import AVFoundation

class ShotDetailViewController: UIViewController {
    //CUSTOM VIEW OUTLETS
    @IBOutlet weak var inOutView: ShotDataDetailView!
    @IBOutlet weak var pointView: ShotDataDetailView!
    @IBOutlet weak var segmentView: ShotDataDetailView!
    @IBOutlet weak var posXView: ShotDataDetailView!
    @IBOutlet weak var posYView: ShotDataDetailView!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var shotDataView: UIView!
    
    var viewModel: ShotDetailViewModel!
    private var player: AVPlayer?
    
    var isRecording: Bool = false {
        didSet {
            if isRecording {
                recordButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            } else {
                recordButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        }
    }
    
    
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
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if viewModel.isRecording {
            self.isRecording = false
            viewModel.stopRecording()
        } else {
            self.isRecording = true
            shotDataView.isHidden = true
            viewModel.startRecording()
        }
    }
    
    func setWaterView() {
        if let shot = viewModel.setShotData() {
            inOutView.setData(name: "IN/OUT", value: String(shot.InOut))
            pointView.setData(name: "POINT", value: String(shot.point))
            segmentView.setData(name: "SEGMENT", value: String(shot.segment))
            posXView.setData(name: "POSX", value: String(format: "%.2f", shot.ShotPosX))
            posYView.setData(name: "POSY", value: String(format: "%.2f", shot.ShotPosY))
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
