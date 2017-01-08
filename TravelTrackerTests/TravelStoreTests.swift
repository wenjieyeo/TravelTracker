//
//  TravelStoreTests.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import XCTest
@testable import TravelTracker
import RealmSwift

class TravelStoreTests: XCTestCase {
    
    var travelStore: TravelStore!
        
    override func setUp() {
        super.setUp()
        travelStore = TravelStore.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCurrentTravel() {
        
        let currentTravel = travelStore.getCurrentTravel()
        XCTAssert(currentTravel.startDate != nil)
        XCTAssert(currentTravel.endDate != nil)
        XCTAssert(currentTravel.distance == 0)
        XCTAssert(currentTravel.identifier == "\(currentTravel.startDate.timeIntervalSince1970)")
    }
    
    func testUpdateTravel() {
        
        let travel = travelStore.getCurrentTravel()
        travel.distance = 20
        travel.endDate = travel.startDate.addingTimeInterval(100)
        travelStore.updateTravel(travel: travel)
        
        Thread.sleep(forTimeInterval: 0.5)
        
        let realm = try! Realm()
        let savedTravel = realm.object(ofType: Travel.self, forPrimaryKey: travel.identifier)

        XCTAssert(savedTravel != nil)
        XCTAssert(savedTravel?.startDate == travel.startDate)
        XCTAssert(savedTravel?.endDate == travel.endDate)
        XCTAssert(savedTravel?.distance == travel.distance)
    }
    
    func testGetLongTravels() {
        
        let travelLong = Travel()
        travelLong.startDate = Date()
        travelLong.identifier = "long"
        travelLong.distance = 51
        travelLong.endDate = Date()
        travelStore.updateTravel(travel: travelLong)
        
        let travelShort = Travel()
        travelShort.startDate = Date()
        travelShort.identifier = "short"
        travelShort.distance = 50
        travelShort.endDate = Date()
        travelStore.updateTravel(travel: travelShort)
        
        Thread.sleep(forTimeInterval: 0.5)
        
        let travels = travelStore.getLongTravels()
        XCTAssert(travels.count > 0)
        XCTAssert(travels.first(where: {$0.identifier == travelLong.identifier}) != nil)
        XCTAssert(travels.first(where: {$0.identifier == travelShort.identifier}) == nil)
        
    }
    
}
