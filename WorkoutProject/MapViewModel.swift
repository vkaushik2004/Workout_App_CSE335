//
//  MapViewModel.swift
//  WorkoutProject
//
//  Created by Ashwini Kumar on 11/30/24.
//


import Foundation
import SwiftUI
import Combine
import MapKit

//So for this I implemented a location manager that saves a users current location
//The simulator cant have access to GPS but I sent a video of this working on my phone in my zipfile or emailed directly to you

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    //random starting coords
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900, longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        //once authorized center to user location
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        //if not request for authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

//this updates the locations once the authorization is gained
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}
