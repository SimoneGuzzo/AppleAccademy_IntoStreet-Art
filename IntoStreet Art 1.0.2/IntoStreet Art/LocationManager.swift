//
//  LocationManager.swift
//  SwiftUI-MapKit
//
//  Created by Vasily Martin on 28/01/2020.
//  Copyright © 2020 Vasily Martin. All rights reserved.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, ObservableObject {
    
    @Published var userLatitude: Double =  0
    @Published var userLongitude: Double = 0
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        print(location)
        
        StreetArtModel.shared.computeDistance(userLocation: location.coordinate)
        StreetArtModel.shared.orderDistance()

    }
}
