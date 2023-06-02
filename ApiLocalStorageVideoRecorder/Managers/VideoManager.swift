//
//  VideoManager.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 2.06.2023.
//

import Foundation
import AVFoundation

class VideoManager {
    func checkForExistingVideo(_ videoName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let videoURL = documentsDirectory.appendingPathComponent("\(videoName).mp4")
        if fileManager.fileExists(atPath: videoURL.path) {
            return videoURL
        } else {
            return nil
        }
    }
    
    func saveVideoToDocumentsFolder(_ videoURL: URL, _ videoName: String) -> Bool {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        
        let destinationURL = documentsDirectory.appendingPathComponent("\(videoName).mp4")
        
        do {
            try fileManager.copyItem(at: videoURL, to: destinationURL)
            return true
        } catch {
            print("Error saving video to documents folder: \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteVideoFromDocumentsFolder(_ videoURL: URL, _ videoName: String) -> Bool {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        
        let destinationURL = documentsDirectory.appendingPathComponent("\(videoName).mp4")
        
        do {
            try fileManager.removeItem(atPath: videoURL.path)
            return true
        } catch {
            print("Error removing video from documents folder: \(error.localizedDescription)")
            return false
        }
        
    }
}
