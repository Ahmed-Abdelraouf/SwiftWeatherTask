//
//  APIClient.swift
//  SwiftWeatherTask
//
//  Created by Oufaa on 13/06/2023.
//

import Foundation
import Combine
import Alamofire
class MainViewClient: APIClient {
   
    class func getWeatherByLocataion(lat:Double,long:Double) -> AnyPublisher<WeatherData, AFError> {
        
        performRequest(route: APIRouter.fetchWeatherByLocation(latitude: lat, longitude: long))
    }
    class func getWeather(nameOrZip:String) -> AnyPublisher<WeatherData, AFError> {
        
        performRequest(route: APIRouter.fetchWeather(nameOrZip: nameOrZip))
    }
    class func getSearchResult(searchTxt:String) -> AnyPublisher<[LocationsData], AFError> {
        
        performRequest(route: APIRouter.autoComplete(searchTxt: searchTxt))
    }

}
