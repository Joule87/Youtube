//
//  AlamofireRequest.swift
//  Youtube
//
//  Created by Julio Collado on 12/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireRequest {
    
    static func createObjectRequest<T: Codable> (request: DataRequest, completionHandler completion: @escaping (Result<T>) -> Void) {
        request.validate()
            .responseJSON { (response) in
                if let data = response.data {
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(value))
                    } catch {
                        print("\(error)")
                        completion(.failure(error: error, data: data))
                    }
                } else {
                    print("NO RESPONSE")
                }
     
        }
    }
    
    static func createDataRequest(request: DataRequest, completionHandler completion: @escaping (Data?) -> Void) {
        request.validate()
            .responseData {
                response in
                if let _ = response.error {
                    completion(nil)
                    return
                }
                guard let data = response.data else{
                    completion(nil)
                    return
                }
                completion(data)
        }
    }
    
}
