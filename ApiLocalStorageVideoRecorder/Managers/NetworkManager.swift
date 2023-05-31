//
//  NetworkManager.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 31.05.2023.
//

import Foundation

class NetworkManager {
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
    
    static let shared = NetworkManager()
    
    func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NetworkError.invalidResponse
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NetworkError.invalidData
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
