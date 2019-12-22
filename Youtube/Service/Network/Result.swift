//
//  Result.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

public enum Result<Value> where Value: Codable{
    case success(Value)
    case failure(error:Error, data: Data?)
}
