//
//  ShotsViewModel.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import Foundation

class ShotsViewModel {
    private var shots: [Shot] = []
    
    func updateShots(_ shots: [Shot]) {
        self.shots = shots
    }
    
    func numberOfShots() -> Int {
        return self.shots.count
    }
    
    func getShot(at index: Int) -> Shot? {
        guard index >= 0 && index < shots.count else { return nil }
        
        return shots[index]
    }
}
