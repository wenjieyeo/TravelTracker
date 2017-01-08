//
//  Travel.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class Travel: Object {
    
    dynamic var startDate: Date!
    dynamic var endDate: Date!
    dynamic var distance: Double = 0
    dynamic var identifier: String!
    
    dynamic var last: CLLocation?
    dynamic var notified = false
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["last", "notified"]
    }
    
}
