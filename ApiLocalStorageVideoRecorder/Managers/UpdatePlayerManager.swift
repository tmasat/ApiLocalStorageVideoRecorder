//
//  UpdatePlayerManager.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import Foundation

class UpdatePlayerManager {
    let coreDataManager: CoreDataManager
    let playerManager: PlayerManager
    
    init(coreDataManager: CoreDataManager, playerManager: PlayerManager) {
        self.coreDataManager = coreDataManager
        self.playerManager = playerManager
    }
    
    func updatePlayers(completion: @escaping () -> Void) {
        playerManager.getPlayerData { result in
            switch result {
            case .success(let players):
                self.coreDataManager.savePlayersAndShots(players: players)
                completion()
            case .failure(let error):
                print("Error on UpdatePlayerManager -> UpdatePlayers: \(error)")
                completion()
            }
        }
    }
}
