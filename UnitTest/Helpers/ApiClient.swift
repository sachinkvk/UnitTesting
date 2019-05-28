//
//  ApiClient.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 28/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    var session: URLSession { get }
}

extension APIClient {
    
    typealias completionHandler = (Decodable?, ServiceErrorCode?) -> Void
    
    func fetch<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping completionHandler) {
        
        Alamofire.request(request).responseData { (response) in
            
            switch response.result {
                
            case .success(let res):
                if response.response?.statusCode == 200 {
                    let model = try? JSONDecoder().decode(decodingType, from: res)
                     completion(model,nil)
                } else {
                    completion(nil,ServiceErrorCode.init(rawValue: (response.response?.statusCode)!))
                }
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil,.INVALID_INPUT)
            }
        }
    }
    
    func createRequest( type : RequestsTypes) -> URLRequest {
        let request = type.request
        return request
    }
}
