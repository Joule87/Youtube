//
//  FeedCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/25/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "FeedCollectionViewCell"
    
    var videos: [Video] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func setupViews() {
        setupCollectionView()
        fetchVideos()
    }
    
    func fetchVideos() {
        let videoAPIClientManager = VideoAPIClientManager()
        videoAPIClientManager.getVideos { [weak self ]result in
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
    
    func setupCollectionView() {
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
}

extension FeedCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftCellSpace = CGFloat(16)
        let rightCellSpace = CGFloat(16)
        let thumbnailImageheight = (frame.width - leftCellSpace - rightCellSpace) * 9/16
        
        let subtitleBottonSpace = CGFloat(16)
        let userProfileImageViewTopSpace = CGFloat(8)
        let userProfileImageViewHeight = CGFloat(44)
        let userProfileImageViewBottomSpace = CGFloat(16)
        let separatorViewHeight = CGFloat(1)
        
        let cellHeight = thumbnailImageheight + subtitleBottonSpace + userProfileImageViewTopSpace + userProfileImageViewHeight + userProfileImageViewBottomSpace + separatorViewHeight
        
        return CGSize(width: frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        cell.thumbnailImageName = videos[indexPath.row].thumbnailImageName
        cell.title = videos[indexPath.row].title
        cell.channelImageName = videos[indexPath.row].channel?.profileImageName
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let channelName = videos[indexPath.row].channel?.name,
            let numberOfViews = videos[indexPath.row].numberOfViews,
            let numberOfViewsFormatted = numberFormatter.string(for: numberOfViews) {
            
            cell.videoDescription = "\(channelName) • \(numberOfViewsFormatted) • 2 years ago"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
        
    }
}


