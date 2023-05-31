//
//  PlayerModel.swift
//  ApiLocalStorageVideoRecorder
//
//  Created by Çağrı Tuğberk Masat on 31.05.2023.
//

import Foundation

struct Player: Codable {
    var name: String
    var surname: String
    var shots: [Shot]
}

struct Shot: Codable {
    var _id: String
    var point: Int
    var segment: Int
    var InOut: Bool
    var ShotPosX: Double
    var ShotPosY: Double
}
