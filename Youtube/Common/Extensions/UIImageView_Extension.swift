//
//  UIImageView_Extension.swift
//  Youtube
//
//  Created by Julio Collado on 12/21/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class UIImageViewLoader: UIImageView {
    
    typealias Completion = (() -> Void)?
    
    var imageUrlString: String?
    
    static let imageCache = NSCache<NSString, AnyObject>()
    
    func loadImage(fromURL url: String, completion: Completion = nil) {
        self.image = nil
        imageUrlString = url
        if let imageFromCache = Self.imageCache.object(forKey: NSString(string: url)) as? UIImage {
            transition(toImage: imageFromCache, completion)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completion?()
            return
        }
        
        ImageClientManager.fetchImage(thumbnailImage: imageURL) { [weak self] response in
            guard let saveSelf = self else { return }
            if let data = response {
                saveSelf.processImageData(data, for: url, completion)
            }
        }
        
    }
    
    private func processImageData(_ data: Data?, for stringUrl: String, _ completion: Completion = nil) {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            completion?()
            return
        }
        
        if self.imageUrlString == stringUrl {
            self.transition(toImage: image, completion)
        }
        Self.imageCache.setObject(image, forKey: NSString(string: stringUrl))
    }
    
    private func transition(toImage image: UIImage, _ completion: Completion = nil) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.image = image
                completion?()
            })
            
        }
    }
    
}
