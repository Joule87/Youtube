//
//  Video.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class Video: Codable {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?
    
    var channel: Channel?
    
    enum CodingKeys: String, CodingKey{
        case thumbnailImageName = "thumbnail_image_name"
        case title
        case numberOfViews = "number_of_views"
        case uploadDate
        case channel
    }
}
