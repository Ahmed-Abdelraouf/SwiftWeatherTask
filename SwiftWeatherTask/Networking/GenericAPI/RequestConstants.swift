//
//  RequestConstants.swift
//  AbsherInterior
//
//  Created by Elsayed Hussein on 9/19/21.
//

import Foundation

struct K {
    

    
    
 //  static var baseURL = "http://154.26.138.231/api/"
//https://api.weatherapi.com/v1/forecast.json?key=bd0deafc57a8421082d72559231106&q=giza&days=7
    static var baseURL = "https://api.weatherapi.com/v1/forecast.json?key=bd0deafc57a8421082d72559231106"
    //    static var baseURL = "http://apistest.haatcard.net/api/"
    static func getFullImagePath(imgUrl:String)-> String{
        
        return "https:\(imgUrl)"

    }


}

//enum HTTPHeaderField: String {
//    case authentication = "Authorization"
//    case contentType = "Content-Type"
//    case acceptType = "Accept"
//    case acceptEncoding = "Accept-Encoding"
//    case acceptLanguage = "Accept-Language"
//    case lang = "lang"
//    
//}
//
//enum ContentType: String {
//    case json = "application/json"
//}
