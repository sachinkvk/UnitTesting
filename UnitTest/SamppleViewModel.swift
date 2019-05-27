//
//  SamppleViewModel.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 27/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation

class SamppleViewModel : ApiRequest{
    
    func fetchList(completion : @escaping (Result<Decodable,ServiceErrorCode>) -> ()) {
        WebService.sharedInstance.fetch(with: request, decodingType: [VideoAssignment].self) { (video, code) in
            if video == nil {
                completion(Result.failure(code!))
            }
            else {
                completion(Result.success(video!))
            }
        }
    }
}

extension SamppleViewModel {
    
    var path: String {
        return "/tenovideo/videos/myvideos-assignment"
    }
    
    var params: [String : Any] {
        return ["page" : "0",
                "size" : "10"
                ]
    }
        
    var httpMethod: HttpType {
        return .get
    }
    
    var headers: [String : String] {
        var header = [String : String]()
        header = ["access-key" : "11654" , "access-token" : "e9bbdf29-7a64-498d-9439-aedfe2eb63ee"]
        header += setHeaders()
        return header
    }
}


extension Dictionary {
    static func += (lhs: inout Dictionary, rhs: Dictionary) {
        lhs.merge(rhs) { (_, new) in new }
    }
}
