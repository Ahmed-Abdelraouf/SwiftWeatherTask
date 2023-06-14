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
    case autoComplete(searchTxt:String)
    var path: String {
        switch self {
        case .fetchWeatherByLocation,.fetchWeather:
            return "forecast.json?"
          
        case .autoComplete:
            return  "search.json?"
    
        }
        
    }
    var method: HTTPMethod {
        switch self {
        case .fetchWeatherByLocation,.fetchWeather,.autoComplete:
            return .get
        }
    
    }
    var queryItems: [URLQueryItem]? {
       switch self {
          case .fetchWeatherByLocation(let lat, let lon):
             return [
                URLQueryItem(name: "q", value: "\(lat),\(lon)"),
                URLQueryItem(name: "key", value: "bd0deafc57a8421082d72559231106"),
                URLQueryItem(name: "days", value: "6")
             ]
          case .fetchWeather(let nameOrZip):
             return [
                URLQueryItem(name: "q", value: nameOrZip),
                URLQueryItem(name: "key", value: "bd0deafc57a8421082d72559231106"),
                URLQueryItem(name: "days", value: "6")
             ]
        case .autoComplete(let searchTxt):
           return [
              URLQueryItem(name: "q", value: searchTxt),
              URLQueryItem(name: "key", value: "bd0deafc57a8421082d72559231106")
           ]
       }
    }
//    var parameters: Parameters? {
//        switch self {
//        case .fetchWeatherByLocation,.fetchWeather,.fetchWeatherByZipCode:
//            return nil
//        }
//    }

}
