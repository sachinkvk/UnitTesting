//
//  SamppleViewModel.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 27/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import Foundation

class SamppleViewModel{
    
    func fetchList(completion : @escaping (Result<Decodable,ServiceErrorCode>) -> ()) {
        let request = WebService.sharedInstance.createRequest(type: .assignment(pageNo: 0, size: 10))
        
        WebService.sharedInstance.fetch(with: request, decodingType: [TenoVideoData].self) { (video, code) in
            guard let video = video else {
                completion(Result.failure(code!))
                return
            }
            completion(Result.success(video))
        }
    }
}

extension Dictionary {
    static func += (lhs: inout Dictionary, rhs: Dictionary) {
        lhs.merge(rhs) { (_, new) in new }
    }
}
