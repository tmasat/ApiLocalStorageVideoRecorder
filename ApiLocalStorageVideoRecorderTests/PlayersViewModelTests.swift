//
//  PlayersViewModelTests.swift
//  ApiLocalStorageVideoRecorderTests
//
//  Created by Çağrı Tuğberk Masat on 5.06.2023.
//

import XCTest
@testable import ApiLocalStorageVideoRecorder

final class PlayersViewModelTests: XCTestCase {
    var playersViewModel: PlayersViewModel!
    var players: [Player]!
    
    
    override func setUp() {
        super.setUp()
        let player1 = Player(name: "Tugberk", surname: "Masat", shots: [Shot(_id: "1", point: 1, segment: 1, InOut: true, ShotPosX: 10.0, ShotPosY: -10.0)])
        let player2 = Player(name: "Player2", surname: "Test2", shots: [Shot(_id: "2", point: 2, segment: 2, InOut: false, ShotPosX: 20.0, ShotPosY: -20.0)])
        let player3 = Player(name: "Player3", surname: "Test3", shots: [Shot(_id: "3", point: 3, segment: 3, InOut: true, ShotPosX: 30.0, ShotPosY: -30.0)])
        
        players = [player1, player2, player3]
        playersViewModel = PlayersViewModel(coreDataManager: CoreDataManager())
        playersViewModel.players = self.players
    }
    
    override func tearDown() {
        playersViewModel = nil
        players = nil
        super.tearDown()
    }
    
    func testGetPlayer() {
        // Nil Assertions
        XCTAssertNotNil(playersViewModel.getPlayer(at: 0))
        XCTAssertNil(playersViewModel.getPlayer(at: 3))
        
        // Name, Surname and Shots Assertions
        var testPlayer1 = playersViewModel.getPlayer(at: 0)
        XCTAssertEqual(testPlayer1?.name, "Tugberk")
        XCTAssertEqual(testPlayer1?.surname, "Masat")
        XCTAssertEqual(testPlayer1?.shots.count, 1)
    }
    
    func testNumberOfPlayers() {
        XCTAssertEqual(playersViewModel.numberOfPlayers(), 3)
    }
    
}
