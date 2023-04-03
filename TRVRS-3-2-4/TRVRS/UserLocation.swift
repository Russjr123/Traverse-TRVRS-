//
//  UserLocation.swift
//  TRVRS
//
//  Created by Mohammad Muksith on 2/28/23.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?

    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
//        let geofenceRegionCenter = CLLocationCoordinate2DMake(42.340115, -83.046341)
//
//        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
//                                              radius: 100,
//                                              identifier: "Ford Field")
        
        let geofenceRegionCenter = CLLocationCoordinate2DMake(42.330985, -83.045995)
       
               let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
                                                     radius: 100,
                                                     identifier: "First National")
               

        geofenceRegion.notifyOnEntry = true

        geofenceRegion.notifyOnExit = true
        
        let content = UNMutableNotificationContent()
        content.title = "You have arrived!"
        content.subtitle = "Take a second to observe your surroundings, you can now press the complete button for this location"
        content.sound = UNNotificationSound.default
        
        let trigger = UNLocationNotificationTrigger(region: geofenceRegion, repeats: true)


        locationManager.startMonitoring(for: geofenceRegion)
     
        
        
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            DispatchQueue.main.async {
                self.location = location
            }
    }
}


