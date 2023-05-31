//
//  PlayerManager.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 31.05.2023.
//

import Foundation

final class PlayerManager {
    private let networkManager = NetworkManager.shared
    
    func getPlayerData(completion: @escaping (Result<[Player], Error>) -> Void) {
        guard let url = URL(string: "https://interview-2dlcobr5jq-ue.a.run.app/shots") else {
            completion(.failure(NetworkManager.NetworkError.invalidURL))
            return
        }
        
        networkManager.get(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let players = try JSONDecoder().decode([Player].self, from: data)
                    completion(.success(players))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
