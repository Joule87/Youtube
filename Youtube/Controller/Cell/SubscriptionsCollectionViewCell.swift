//
//  SubscriptionsCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/26/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class SubscriptionsCollectionViewCell: FeedCollectionViewCell {
    static let subscriptionsCellIdentifier =  "SubscriptionsCollectionViewCell"
    
    override func fetchVideos() {
        let videoAPIClientManager = VideoAPIClientManager()
        videoAPIClientManager.getSubscriptionsVideos { [weak self ]result in
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
