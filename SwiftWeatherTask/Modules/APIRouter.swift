//
//  APIRouter.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 13/06/2023.
//

import Foundation
import Alamofire
//api/
enum APIRouter: APIConfiguration {
    //api/Account/GetQrCode
    case fetchWeatherByLocation(latitude: Double, longitude: Double)
    case fetchWeather(nameOrZip: String)

    var path: String {
        switch self {
        case .fetchWeatherByLocation(let latitude, let longitude):
            return "&q=\(latitude),\(longitude)"
          
        case .fetchWeather(let nameOrZip):
            return  "&q=\(nameOrZip)"
    
        }
        
    }
    var method: HTTPMethod {
        switch self {
        case .fetchWeatherByLocation,.fetchWeather:
            return .get
        }
    
    }
    
//    var parameters: Parameters? {
//        switch self {
//        case .fetchWeatherByLocation,.fetchWeather,.fetchWeatherByZipCode:
//            return nil
//        }
//    }

}
