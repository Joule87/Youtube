//
//  Channel.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class Channel: Codable {
    var name: String?
    var profileImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}
