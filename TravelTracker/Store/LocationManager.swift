//
//  LocationManager.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI
import Contacts
import AddressBookUI

protocol LocationManagerDelegate: NSObjectProtocol {
    func locationManager(manager: LocationManager, didSaveTravel travel: Travel)
}

class LocationManager: NSObject {
    
    public static let sharedInstance = LocationManager()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    weak var delegate: LocationManagerDelegate?
    
    func startTracking() {
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func getAddress(from location: CLLocation, completion: @escaping (String?) -> Void) {
        
        CLGeocoder().reverseGeocodeLocation(
            location,
            completionHandler: { placemarks, error in
                if let count = placemarks?.count, count > 0 {
                    let placemark = placemarks![0]
                    let address = self.formattedAddress(for: placemark.addressDictionary!)
                    completion(address)
                    return
                }
                completion(nil)
        })
    }
    
    @available(iOS 9.0, *)
    func postalAddress(from addressdictionary: [AnyHashable : Any]) -> CNMutablePostalAddress {
        let address = CNMutablePostalAddress()
        
        address.street = addressdictionary["Street"] as? String ?? ""
        address.state = addressdictionary["State"] as? String ?? ""
        address.city = addressdictionary["City"] as? String ?? ""
        address.country = addressdictionary["Country"] as? String ?? ""
        address.postalCode = addressdictionary["ZIP"] as? String ?? ""
        
        return address
    }
    
    func formattedAddress(for addressDictionary: [AnyHashable : Any]) -> String {
        if #available(iOS 9.0, *) {
            return CNPostalAddressFormatter.string(from: postalAddress(from: addressDictionary), style: .mailingAddress)
        } else {
            return ABCreateStringWithAddressDictionary(addressDictionary, true)
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways  || status == .authorizedWhenInUse {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let travel = TravelStore.sharedInstance.getCurrentTravel()
        
        var updated = false
        
        
        for location in locations {
            if let last = travel.last {
                let delta: Double = location.distance(from: last)
                if delta < 100  { // hack: for debugging purpose in simulator
                    print("\(last.coordinate)")
                    travel.distance += delta
                }
            }
            travel.last = location
            currentLocation = location
            updated = true
        }
        
        if updated {
            // check if exceed 50 meters
            if !travel.notified && travel.distance > 50 {
                travel.notified = true
                let notification = UILocalNotification()
                notification.alertBody = "You are traveling more than 50 meters."
                UIApplication.shared.presentLocalNotificationNow(notification)
            }
            
            // save to db
            travel.endDate = Date()
            TravelStore.sharedInstance.updateTravel(travel: travel)
        }
        
        self.delegate?.locationManager(manager: self, didSaveTravel: travel)
    }
}
