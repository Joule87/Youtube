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
    
    let apiBase: String = "https://api.myjson.com/"
    let videoPath: String = "bins/"
    
    func getVideos() -> DataRequest {
        ///https://www.s3-us-west-2.amazonaws.com/youtubeassets/home.json
        let homeVideo = "14tqww"
        let url = apiBase + videoPath + homeVideo
        return AF.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
    
    func getTrendingVideos() -> DataRequest {
        ///https://www.s3-us-west-2.amazonaws.com/youtubeassets/trending.json
        let homeVideo = "qkf1w"
        let url = apiBase + videoPath + homeVideo
        return AF.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
    
    func getSubscriptionVideos() -> DataRequest {
        ///https://s3-us-west-2.amazonaws.com/youtubeassets/subscription.json
        let homeVideo = "b5ahg"
        let url = apiBase + videoPath + homeVideo
        return AF.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
    
}
