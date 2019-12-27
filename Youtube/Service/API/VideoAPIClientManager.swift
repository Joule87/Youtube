//
//  VideoAPIManager.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

struct VideoAPIClientManager {
    
    func getVideos(completion: @escaping (Result<[Video]>) -> Void) {
        let videoDataRequest = VideoAPI().getVideos()
        AlamofireRequest.createObjectRequest(request: videoDataRequest) { (result) in
            completion(result)
        }
        
    }
    
    func getTrendingVideos(completion: @escaping (Result<[Video]>) -> Void) {
        let videoDataRequest = VideoAPI().getTrendingVideos()
        AlamofireRequest.createObjectRequest(request: videoDataRequest) { (result) in
            completion(result)
        }
        
    }
    
    func getSubscriptionsVideos(completion: @escaping (Result<[Video]>) -> Void) {
        let videoDataRequest = VideoAPI().getSubscriptionVideos()
        AlamofireRequest.createObjectRequest(request: videoDataRequest) { (result) in
            completion(result)
        }
    }
}
