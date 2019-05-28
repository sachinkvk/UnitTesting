//
//  ApiRequest.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 28/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation

protocol ApiResource {
    var path : String { get }
    var params : [String : Any] { get }
    var method : HttpType { get }
    var request: URLRequest { get }
}

enum RequestsTypes{
    case login
    case sharedByVideos
    case assignment(pageNo : Int,size : Int)
    case videoTopic
}

protocol HttpHeaders {
    var userSpecificHeaders : [ String: String] { get }
}

extension RequestsTypes : ApiResource{
    private var baseUrl : String {
        return "http://sandbox.tenoapp.com:707"
    }
    
    var method: HttpType {
        switch self {
        case .assignment( _ ,  _):
            return .get
        default:
            return .post
        }
    }
    
    var path : String {
        switch self {
        case .assignment( _ ,  _):
            return "/tenovideo/videos/myvideos-assignment"
            
        default:
            return ""
        }
    }
    
    var params : [String : Any] {
        switch self {
        case .login:
            return ["":""]
        case .assignment(let pageNo , let size):
            return ["page" : pageNo,"size" : size]
        default:
            return ["":""]
        }
    }
    
    
    
    private var urlComponents: URLComponents {
        var components = URLComponents(string: baseUrl)!
        components.path = path
        if method == HttpType.get {
            var query = [URLQueryItem]()
            params.forEach { (param) in
                let (k, v) = param
                query.append(URLQueryItem(name: k, value: "\(v)"))
            }
            components.queryItems = query
        }
        //url encoding
        return components
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        if method == HttpType.post {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = data
            
        }
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        return request
    }
}

extension RequestsTypes : HttpHeaders {
    var userSpecificHeaders: [String : String] {
        var header = [String : String]()
        header = ["access-key" : "11654" , "access-token" : "e9bbdf29-7a64-498d-9439-aedfe2eb63ee"]
        return header
    }
    
    private func setDefaultHeaders() -> [String : String] {
        var param = [String : String]()
        param["userId"] = "11654"
        param["x-device-model"] = ""
        param["x-source"] = "ios"
        param["x-os-version"] = ProcessInfo.processInfo.operatingSystemVersionString
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        param["x-app-version-name"] = version
        //        params["x-app-version-code"] = String(describing: myDict["currentVersion"]!)
        return param
    }
    
    var headers : [String : String ] {
        var header  = userSpecificHeaders
        header += setDefaultHeaders()
        return header
    }
}
