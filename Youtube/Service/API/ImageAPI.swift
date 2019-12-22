//
//  ImageAPI.swift
//  Youtube
//
//  Created by Julio Collado on 12/21/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

struct ImageAPI {
    
    func getImage(thumbnailImage: URL) -> DataRequest {
        return AF.request(thumbnailImage,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
}
