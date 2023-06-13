//
//  WeatherModel.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 12/06/2023.
//

import Foundation
struct WeatherData: Decodable {
    let location: CurrentLocation
    let current: CurrentDegree
    let forecast: Forecast
}

struct CurrentLocation: Decodable {
    let name:String
}
struct CurrentDegree: Decodable {
    let temp_c:Double
    let temp_f:Double
    let condition: TempCondition
    
}
struct Forecast: Decodable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Decodable {
    let day: Day
 
}
struct Day: Decodable {
    let maxtemp_c:Double
    let avgtemp_c:Double
    let condition:TempCondition
}

struct TempCondition: Decodable {
    let text: String
    let icon: String
    let code: Int
}
