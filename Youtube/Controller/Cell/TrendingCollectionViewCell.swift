//
//  TrendingCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/26/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: FeedCollectionViewCell {
    
    static let trendingCellIdentifier =  "TrendingCollectionViewCell"
    
    override func fetchVideos() {
        let videoAPIClientManager = VideoAPIClientManager()
        videoAPIClientManager.getTrendingVideos { [weak self ]result in
            guard let saveSelf = self else { return }
            switch result {
            case .success(let value):
                saveSelf.videos = value
                saveSelf.collectionView.reloadData()
            case .failure(let error, _):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
