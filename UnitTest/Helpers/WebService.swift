//
//  File.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 27/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation
import Alamofire

struct VideoAssignment : Codable {
    var video : TenoVideoData
    let videoAssignmentID : Int?
    let groupID : Int64?
    let childID : Int?
    let shareDate : Int64?
    let assignerID : Int?
    let assignerRole : String?
    var sharedDateinDateFormat : String?
}

struct TenoVideoData: Codable {
    let board, dashKey, dashVideoURL: String?
    let description, hlsKey, hlsVideoURL: String?
    let id , updateDate, createDate: Int64?
    var isBookmarked, isDeleted, isWatched: Bool?
    let length, noOfViews, order: Int?
    var rating, myRating: Int?
    let standard, subTopic, subject, tags: String?
    let tenoVideoID, topic,  videoChannelID: String?
    let videoState, videoThumbnailURL, videoTitle, videoTranscodeID: String?
    var watchedLength: Int64?
    let role : String?
    let schoolId : Int64?
    
    enum CodingKeys: String, CodingKey {
        case board, createDate, dashKey
        case dashVideoURL = "dashVideoUrl"
        case description, hlsKey
        case hlsVideoURL = "hlsVideoUrl"
        case id, isBookmarked, isDeleted, isWatched, length, myRating, noOfViews, order, rating, standard, subTopic, subject, tags
        case tenoVideoID = "tenoVideoId"
        case topic, updateDate
        case videoChannelID = "videoChannelId"
        case videoState
        case videoThumbnailURL = "videoThumbnailUrl"
        case videoTitle
        case videoTranscodeID = "videoTranscodeId"
        case watchedLength
        case role
        case schoolId
    }
}


enum ServiceErrorCode : Int {
    case SUCCESS = 200
    case CREATED = 201
    case SUCCESS_LITE_DATA = 206
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case INVALID_INPUT = 422
    case NO_DATA = 204
    case DUPLICATE_DATA = 409// OR QUESTION_NOTELIGIBLE_FOR_REVIEW
    case OTHER = -1
    case NO_INTERNET_CONNECTION = -2
    case SERVER_ERROR = -3
    case NO_RESOURCEDATA = 404
    case SERVICE_UNAVAILABLE = 503
    
    var description: String?{
        
        switch self {
        case .SUCCESS:
            return "Success"
        case .CREATED:
            return "Created"
        case .SUCCESS_LITE_DATA:
            return "Success Lite Data"
        case .UNAUTHORIZED:
            return "Unauthorized User"
        case .FORBIDDEN:
            return "Forbidden"
        case .INVALID_INPUT:
            return "Something went wrong"
        case .NO_DATA:
            return "No Data"
        case .OTHER:
            return "Something went wrong"
        case .NO_INTERNET_CONNECTION:
            return "No internet. Please check your connection"
        case .SERVER_ERROR:
            return "Our servers are unreachable, could not fetch data. Try again later"
        case .NO_RESOURCEDATA:
            return "no data"
        case .DUPLICATE_DATA:
            return "Duplicate data(Already posted)"
        case .SERVICE_UNAVAILABLE:
            return "Service is unavailable"
        }
    }
}

enum URLS : String {
    case mainURL = "app_url"
    case authorprofile = "authorprofile"
    case subjects = "subjects"
    case worksheets = "worksheets"
    case cms = "cms"
    case question = "question_url"
    case prime = "prime_subscription"
    case videos = "teno_videos"
}

enum Result <T,Error> {
    case success(T)
    case failure(Error)
}

enum HttpType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

protocol HttpHeaders {
    var userSpecificHeaders : [ String: String] { get }
}

extension HttpHeaders {
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

protocol ApiResource : HttpHeaders {
    var path : String { get }
    var method : HttpType { get }
    var params : [String : Any] { get }
}

extension ApiResource {
    
    private var baseUrl : String {
        return "http://sandbox.tenoapp.com:7078/tenovideo"
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
}

class WebService : APIClient {
    
    static let sharedInstance = WebService()
    private init() { }
    
    let session = URLSession(configuration: .default)
}

//class TestRest : APIClient {
//
//    let session: URLSession
//
//    init(configuration: URLSessionConfiguration) {
//        self.session = URLSession(configuration: configuration)
//    }
//
//    convenience init() {
//        self.init(configuration: .default)
//    }
//
//    typealias completionHandler = (Result<Person, ServiceErrorCode>) -> Void
//    var request = URLRequest(url: URL(string: "")!)
//
//    func startCalling(completion: @escaping completionHandler) {
//        fetch(with: request, decode: { json -> Person? in
//            guard let person = json as? Person else { return  nil }
//            return person
//        }, completion: completion)
//    }
//}
