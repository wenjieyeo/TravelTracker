//
//  CurrentTravelControllerTests.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import XCTest
@testable import TravelTracker

class CurrentTravelControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowCurrentDistance() {
        
        let travel = TravelStore.sharedInstance.getCurrentTravel()
        travel.distance = 20
        
        let travelVC = CurrentTravelController()
        travelVC.distanceLabel = UILabel()
        
        travelVC.viewWillAppear(true)
        XCTAssert(travelVC.distanceLabel.text == "20 m")
    }
    
}
