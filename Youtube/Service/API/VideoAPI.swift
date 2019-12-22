//
//  VideoAPI.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

struct VideoAPI {
    
    let apiBasePath: String = "https://api.myjson.com/bins/14tqww"
    
    func getVideos() -> DataRequest {
        let url = "\(apiBasePath)"
        return AF.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
}
