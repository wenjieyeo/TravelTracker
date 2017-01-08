//
//  TravelStore.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import RealmSwift

class TravelStore: NSObject {
    
    public static let sharedInstance = TravelStore()
    private var currentTravel: Travel?
    
    func getCurrentTravel() -> Travel {
        
        if let travel = currentTravel {
            return travel
        }
        
        let travel = Travel()
        travel.startDate = Date()
        travel.endDate = Date()
        travel.identifier = "\(travel.startDate.timeIntervalSince1970)"
        currentTravel = travel
        
        return travel
    }
    
    func updateTravel(travel: Travel) {
        DispatchQueue(label: "db").async {
            let realm = try! Realm()
            try! realm.write {
                realm.create(Travel.self, value: travel, update: true)
            }
        }
    }
    
    func getLongTravels() -> [Travel] {
        let realm = try! Realm()
        let result = realm.objects(Travel.self).filter("distance > %d", 50).sorted(byProperty: "startDate", ascending: false)
        
        var res = [Travel]()
        for travel in result {
            res.append(travel)
        }
        return res
    }
}
