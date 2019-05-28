//
//  ApiClient.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 28/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
}

extension APIClient {
    
    typealias completionHandler = (Decodable?, ServiceErrorCode?) -> Void
    
    func fetch<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping completionHandler) {
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(nil,.INVALID_INPUT)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .SERVER_ERROR)
                return
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                do {
                    let jsonModel = try JSONDecoder().decode(decodingType, from: data)
                    completion(jsonModel, nil)
                } catch {
                    completion(nil, .NO_RESOURCEDATA)
                }
                
            } else if httpResponse.statusCode == 205 {
                completion(nil, .NO_DATA)
                
            } else {
                completion(nil, .OTHER)
            }
            }.resume()
    }
    
    func createRequest(type : RequestsTypes) -> URLRequest {
        let request = type.request
        return request
    }
}
