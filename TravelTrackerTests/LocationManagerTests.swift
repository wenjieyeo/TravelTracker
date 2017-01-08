//
//  LocationManagerTests.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import XCTest
@testable import TravelTracker
import CoreLocation

class LocationManagerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetAddress() {
        
        let locationManager = LocationManager.sharedInstance
        
        let expect = expectation(description: "getAddress")
        
        let location = CLLocation(latitude: 37.33259552, longitude: -122.03031802) // Apple
        locationManager.getAddress(from: location) { address in
            //XCTAssert(address == "2 Infinite Loop\nCupertino CA 95014\nUnited States")
            XCTAssert(address != nil)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "Something went horribly wrong")
        }
    }
    
    func testDidChangeAuthorizationBeingCalled() {
        
        let expect = expectation(description: "Authorization")
        
        class LocationManagerMock: LocationManager {
            var expect: XCTestExpectation?
            override func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                expect?.fulfill()
            }
        }
        
        let locationManager = LocationManagerMock()
        locationManager.expect = expect
        locationManager.startTracking()
        
        waitForExpectations(timeout: 1) { error in
        }
    }
    
    func testUpdateLocationsBeingCalled() {
        
        // Note : You need to simulate the location in order to pass this this case
        // Simulator -> Debug -> Location -> Choose a location there
        
        let expect = expectation(description: "Authorization")
        
        class LocationManagerMock: LocationManager {
            var expect: XCTestExpectation?
            override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                expect?.fulfill()
            }
        }
        
        let locationManager = LocationManagerMock()
        locationManager.expect = expect
        locationManager.startTracking()
        
        waitForExpectations(timeout: 3) { error in
        }
    }
    
    func testUpdateLocations() {
        
        let locationManager = LocationManager.sharedInstance
        let clManager = CLLocationManager()
        
        
        let locations = [CLLocation(latitude: 37.335274759999997, longitude: -122.03254703),
                         CLLocation(latitude: 37.335255519999997, longitude: -122.03254837999999),
                         CLLocation(latitude: 37.335235660000002, longitude: -122.03254862999999),
                         CLLocation(latitude: 37.335215040000001, longitude: -122.03254905),
                         CLLocation(latitude: 37.335195720000002, longitude: -122.0325498),
                         CLLocation(latitude: 37.33517518, longitude: -122.03255055),
                         CLLocation(latitude: 37.335150830000003, longitude: -122.03255349),
                         CLLocation(latitude: 37.335121200000003, longitude: -122.03256229),
                         CLLocation(latitude: 37.335071620000001, longitude: -122.0326037),
                         CLLocation(latitude: 37.335038679999997, longitude: -122.03265072000001),
                         CLLocation(latitude: 37.33500926, longitude: -122.03272188),
                         CLLocation(latitude: 37.334977369999997, longitude: -122.03281282),
                         CLLocation(latitude: 37.334977369999997, longitude: -122.03291282)]
        
        
        locationManager.locationManager(clManager, didUpdateLocations: locations)
        
        let travel = TravelStore.sharedInstance.getCurrentTravel()
        XCTAssert(travel.distance > 50)
        XCTAssert(travel.notified)
    }
    
}
