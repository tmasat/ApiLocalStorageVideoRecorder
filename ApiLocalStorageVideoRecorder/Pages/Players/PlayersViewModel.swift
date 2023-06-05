//
//  PlayersViewModel.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 1.06.2023.
//

import Foundation

protocol PlayersViewModelDelegate: AnyObject {
    func didFetchPlayers()
}

class PlayersViewModel {
    private let coreDataManager: CoreDataManager
    var players: [Player] = []
    weak var delegate: PlayersViewModelDelegate?
    private let updatePlayerManager = UpdatePlayerManager(coreDataManager: CoreDataManager(), playerManager: PlayerManager())
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    
    func isUpdateNeeded() {
        guard self.players.count == 0 else { return }
        
        updatePlayerManager.updatePlayers {
            self.fetchPlayers()
        }
    }
    
    func fetchPlayers() {
        self.players = coreDataManager.fetchPlayers()
        delegate?.didFetchPlayers()
    }
    
    func numberOfPlayers() -> Int {
        return players.count
    }
    
    func getPlayer(at index: Int) -> Player? {
        guard index >= 0 && index < players.count else {
            return nil
        }
        return players[index]
    }
}
