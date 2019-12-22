//
//  ImageClientManager.swift
//  Youtube
//
//  Created by Julio Collado on 12/21/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

struct ImageClientManager {
    
    static func fetchImage(thumbnailImage: URL, completion: @escaping (Data?) -> Void) {
        let imageDataRequest = ImageAPI().getImage(thumbnailImage: thumbnailImage)
        AlamofireRequest.createDataRequest(request: imageDataRequest) { (data) in
            completion(data)
        }
        
    }
}
