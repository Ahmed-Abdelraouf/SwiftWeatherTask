//
//  APIConfiguration.swift
//  AbsherInterior
//
//  Created by Elsayed Hussein on 9/19/21.
//

import Alamofire

import Foundation
typealias HTTPMethod = Alamofire.HTTPMethod
typealias Parameters = Alamofire.Parameters

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var queryItems: [URLQueryItem]? { get }
    var hasLoading: Bool { get }
    var baseURL: String {get}
}
extension APIConfiguration {
    var method: HTTPMethod { .get }
    var parameters: Parameters? { nil }
    var hasLoading: Bool { false }
    var baseURL: String {
        
    
        return K.baseURL
        
    }
    
    func asURLRequest() throws -> URLRequest {
        
//        if UserStatus.isLogged {
//            if let token = UserStatus.user?.authorization, token.isEmpty {
//                throw AFError.invalidURL(url: URL(string: path)!)
//            }
//        }
        
        //        let url = try K.ProductionServer.baseURL.asURL()
        if let parameters = parameters {
            print("🧵 Parameters", parameters)
        } else {
            print("🧵 Parameters nil")
        }
//        var urlComponent = URLComponents(string: K.apiBaseURL + path)
        var urlComponent = URLComponents(string: baseURL + path)
        urlComponent?.queryItems = queryItems
//        if method == .get  || method == .delete  {
//            print("method is get here ")
//            urlComponent?.queryItems = [URLQueryItem]()
//            print("method is get here parameters \(String(describing: parameters))")
//            for parameter in parameters ?? [:] {
//                
//                var value = "\(parameter.value)"
//                if let multiSet = parameter.value as? Set<Int> {
//                    value = multiSet.map({"\($0)"}).joined(separator: ",")
//                }
//                urlComponent?.queryItems?.append(URLQueryItem(name: parameter.key, value: value))
//            }
//        }
        guard let url = urlComponent?.url else {
            throw AFError.invalidURL(url: URL(string: path)!)
        }
        print(" all url = \(url)" )
        
        
        var cc = ""
        print(cc)
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            cc = countryCode
        }
        
       
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
//        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)


        return urlRequest
    }
}
