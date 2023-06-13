//
//  LocationManager.swift
//  Haat Card
//
//  Created by Oufaa on 28/12/2022.
//
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var locationPublisher: CurrentValueSubject<CLLocation?, Never> = CurrentValueSubject(nil)

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

   
    
    var statusCheck: Bool {
        guard let status = locationStatus else {
            return false
        }
        
        switch status {
        case .notDetermined: return false
        case .authorizedWhenInUse: return true
        case .authorizedAlways: return true
        case .restricted: return false
        case .denied: return false
        default: return false
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
//        print(#function, statusString)
    }
    func location() -> AnyPublisher<CLLocation?, Never> {
       return locationPublisher.eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       guard let newLocation = locations.last else { return }
            locationManager.stopUpdatingLocation()
        if shouldUpdateLocation(to: newLocation) {
           locationPublisher.send(newLocation)
        }

      
      
    }
    private func shouldUpdateLocation(to location: CLLocation) -> Bool {
       guard let lastKnownLocation = locationPublisher.value else { return true }
       let distanceInMeters = Measurement(value: lastKnownLocation.distance(from: location), unit: UnitLength.meters)
       let distanceInMiles = distanceInMeters.converted(to: .miles)
       if distanceInMiles.value > 2 { return true }
       return false
    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        lastLocation = location
//        locationManager.stopUpdatingLocation()
////        print(#function, location)
//    }
}
