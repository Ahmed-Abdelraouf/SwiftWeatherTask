//
//  APIClient.swift
//  AbsherInterior
//
//  Created by Elsayed Hussein on 9/19/21.
//

import Alamofire
import Combine
import Foundation


enum MediaChaType {
    case image , audio , video , pdf , text
}

class APIClient {
    @discardableResult
    static func performRequest<T: Decodable>(route: APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, AFError> {
        return Future({ completion in

            print("route \(route)")
            AF.request(route).responseData(completionHandler: { (response) in
    
                print("🔗", route)
                if let v = response.data {
                    print("💽", String(data: v, encoding: .utf8)!)
                    //                    try! decoder.decode(T.self, from: v)
                }
            })
            .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                if route.hasLoading {
                    //                    LoaderView(isDisplayed: false)
                }
                print(response.result)
                
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    if response.response?.statusCode == 401 {
                        //      AppManager.timeOverAuthenticate(isTokenExpired: true)
                        
                    }else {
                        print("⚠️ ⚠️ Error", error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            })
        }).eraseToAnyPublisher()
    }
     
}

