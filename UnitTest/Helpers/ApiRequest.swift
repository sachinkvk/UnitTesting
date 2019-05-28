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
        return "http://sandbox.tenoapp.com"
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
//            return "/videos/myvideos"
            return "/worksheets/search"
            
        default:
            return ""
        }
    }
    
    var params : [String : Any] {
        switch self {
        case .login:
            return ["":""]
        case .assignment(let pageNo , let size):
//            return ["page" : pageNo,"size" : size]
            return ["text" : "Algebra","page":pageNo,"size" : size,"standard" : ["6","8"],"subject" : "Mathematics","board":"CBSE","lite":"1"]
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
                if let arr = v as? Array<String> {
                    print(k)
                    arr.forEach({ (val) in
                        query.append(URLQueryItem(name: k, value: val))
                    })
                }
                else {
                    query.append(URLQueryItem(name: k, value: "\(v)"))
                }
            }
            components.queryItems = query
        }
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
        header = ["access-key" : "12018" , "access-token" : "6a108135-ca19-4d20-a8f7-28f16b507744"]
        return header
    }
    
    private func setDefaultHeaders() -> [String : String] {
        var param = [String : String]()
        param["userId"] = "12018"
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
