//
//  CoreDataManager.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 31.05.2023.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ApiLocalStorageVideoRecorder")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Failed to save Core Data context: \(nsError)")
            }
        }
    }

    func savePlayerAndShots(name: String, surname: String, shots: [Shot]) {
        let player = PlayerEntity(context: context)
        player.name = name
        player.surname = surname

        for shot in shots {
            let shotEntity = ShotEntity(context: context)
            shotEntity.point = Int32(shot.point)
            shotEntity.segment = Int32(shot.segment)
            shotEntity.id = shot._id
            shotEntity.inOut = shot.InOut
            shotEntity.posX = shot.ShotPosX
            shotEntity.posY = shot.ShotPosY
            player.addToShots(shotEntity)
        }

        saveContext()
    }

    func fetchPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<PlayerEntity> = PlayerEntity.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["shots"]

        do {
            let playerEntities = try context.fetch(fetchRequest)
            var players: [Player] = []

            for playerEntity in playerEntities {
                guard let name = playerEntity.name, let surname = playerEntity.surname else {
                    continue
                }
                var shots: [Shot] = []

                if let shotEntities = playerEntity.shots as? Set<ShotEntity> {
                    for shotEntity in shotEntities {
                        
                        var id = shotEntity.id
                        var point = Int(shotEntity.point)
                        var segment = Int(shotEntity.segment)
                        var inOut = shotEntity.inOut
                        var posX = shotEntity.posX
                        var posY = shotEntity.posY
                        
                        
//                        guard let id = shotEntity.id,
//                              let point = shotEntity.point,
//                              let segment = shotEntity.segment,
//                              let inOut = shotEntity.inOut,
//                              let posX = shotEntity.posX,
//                              let posY = shotEntity.posY else {
//                            continue
//                        }
                        
                        
                        let shot = Shot(_id: id ?? "", point: point, segment: segment, InOut: inOut, ShotPosX: posX, ShotPosY: posY)
                        shots.append(shot)
                    }
                }

                let player = Player(name: name, surname: surname, shots: shots)
                players.append(player)
            }

            return players
        } catch {
            print("Failed to fetch players: \(error)")
            return []
        }
    }

    
    
}
