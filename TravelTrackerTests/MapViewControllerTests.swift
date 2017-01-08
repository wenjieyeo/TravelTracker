//
//  MapViewControllerTests.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import XCTest
import MapKit
@testable import TravelTracker

class MapViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowAddress() {
        
        class UserLocation: MKUserLocation {
            override var location: CLLocation? {
                get {
                    return CLLocation(latitude: 37.33259552, longitude: -122.03031802) // Apple
                }
            }
        }
        
        let location = UserLocation()
        let mapVC = MapViewController()
        let mapView = MKMapView()
        let expect = expectation(description: "")
        
        mapVC.addressLabel = UILabel()
        
        mapVC.mapView(mapView, didUpdate: location)
        
        DispatchQueue(label: "background").async {
            Thread.sleep(forTimeInterval: 5)
            expect.fulfill()
        }
        
        
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssert(mapVC.addressLabel.text?.lengthOfBytes(using: .utf8) ?? 0 > 0)
        })
        
    }
    
}
