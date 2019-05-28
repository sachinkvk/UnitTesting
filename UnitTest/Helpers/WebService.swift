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
    case METHOD_NOT_FOUND = 405
    
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
        case .METHOD_NOT_FOUND :
            return "method not found"
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

class WebService : APIClient {
    
    static let sharedInstance = WebService()
    private init() { }
    
    var session : URLSession {
       return URLSession(configuration: .default)
    }
    
}

