//
//  MainViewModel.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 11/06/2023.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI
import Network
import SystemConfiguration
// An enum to handle the network status
class MainViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var weather:WeatherData?
    private var cancellable: Set<AnyCancellable> = []
    private var locationSubscription: AnyCancellable?
    var locationManager  = LocationManager ()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var status: NetworkStatus = .connected
    @Published var isError = false
    @Published var errorMessage = "Please turn on location to get your current location weather"
    var userLatitude: Double?
       
    var userLongitude: Double?
    init() {
       setupLocationSubscription()
        setupNetworkReachability()
    }
    func fetchWeather(){
       isLoading = true
        print("IsLoading")
        if  self.status == .disconnected{
            self.isError = true
            self.errorMessage =  "Please check internet connection"
            return 
        }
        MainViewClient.getWeather(nameOrZip: searchText)
           // .print()
            .receive(on: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink { comp in


            } receiveValue: { [weak self] result in
                self?.weather = result
                self?.isLoading = false
            }.store(in: &cancellable)

    }
    func fetchWeatherByLocation(){
       isLoading = true
        print("IsLoading")
        if checkConnection(){return}
            MainViewClient.getWeatherByLocataion(lat: userLatitude!, long: userLongitude!)
            // .print()
                .receive(on: RunLoop.main)
                .subscribe(on: RunLoop.main)
                .sink { comp in
                    
                    
                } receiveValue: { [weak self] result in
                    self?.weather = result
                    self?.isLoading = false
                }.store(in: &cancellable)
       
    }
    func temp(temp:Double?) -> String {
        if let temp = temp {
         return String(format: "%.1f", temp)
        }
        else{
            return "0"
        }
    }
    private func setupLocationSubscription() {
       locationSubscription = locationManager.location().sink { [weak self] location in
          guard let self = self else { return }
          guard let newLocation = location else {
              if !self.locationManager.statusCheck{
                  self.isError = true
              }
              return }
          
           self.userLatitude = newLocation.coordinate.latitude
           self.userLongitude = newLocation.coordinate.longitude
           self.fetchWeatherByLocation()
       }
    }
    
private func setupNetworkReachability() {
    monitor.pathUpdateHandler = { [weak self] path in
        guard let self = self else { return }

        DispatchQueue.main.async {
            if path.status == .satisfied {
                self.status = .connected
            } else {
                self.status = .disconnected
            }
        }
    }
    monitor.start(queue: queue)

    }
    
    private func checkConnection() -> Bool {
        if !self.locationManager.statusCheck{
            self.isError = true
            self.errorMessage =  "Please turn on location to get your current location weather"
            return true
        }
        if  self.status == .disconnected{
            self.isError = true
            self.errorMessage =  "Please check internet connection"
            return true
        }
        return false
    }
    
    
}

enum NetworkStatus: String {
    case connected
    case disconnected
}

