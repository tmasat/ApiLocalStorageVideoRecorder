//
//  ShotsViewModelTests.swift
//  ApiLocalStorageVideoRecorderTests
//
//  Created by Çağrı Tuğberk Masat on 5.06.2023.
//

import XCTest
@testable import ApiLocalStorageVideoRecorder

final class ShotsViewModelTests: XCTestCase {
    var shotsViewModel: ShotsViewModel!
    var shots: [Shot]!
    
    override func setUp() {
        super.setUp()
        let shot1 = Shot(_id: "1", point: 1, segment: 1, InOut: true, ShotPosX: 10.0, ShotPosY: -10.0)
        let shot2 = Shot(_id: "2", point: 2, segment: 2, InOut: false, ShotPosX: 20.0, ShotPosY: -20.0)
        let shot3 = Shot(_id: "3", point: 3, segment: 3, InOut: true, ShotPosX: 30.0, ShotPosY: -30.0)
        shots = [shot1, shot2, shot3]
        shotsViewModel = ShotsViewModel()
        shotsViewModel.updateShots(shots)
    }
    
    override func tearDown() {
        shotsViewModel = nil
        shots = nil
        super.tearDown()
    }
    
    func testNumberOfShots() {
        XCTAssertEqual(shotsViewModel.numberOfShots(), shots.count)
    }
    
    func testGetShot() {
        XCTAssertNotNil(shotsViewModel.getShot(at: 0))
        XCTAssertNil(shotsViewModel.getShot(at: 3))
        
        // _id, point, segment, inOut, shotPosX and shotPosY assertions
        var testShot1 = shotsViewModel.getShot(at: 0)
        XCTAssertEqual(testShot1?._id, "1")
        XCTAssertEqual(testShot1?.point, 1)
        XCTAssertEqual(testShot1?.segment, 1)
        XCTAssertEqual(testShot1?.InOut, true)
        XCTAssertEqual(testShot1?.ShotPosX, 10.0)
        XCTAssertEqual(testShot1?.ShotPosY, -10.0)
    }
}
