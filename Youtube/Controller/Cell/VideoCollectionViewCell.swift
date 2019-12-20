//
//  VideoCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/15/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "VideoCollectionViewCell"
    
    var thumbnailImageName: String? {
        didSet {
            if let thumbnailImageName = thumbnailImageName {
                thumbnailImageView.image = UIImage(named:  thumbnailImageName)
            }
        }
    }
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
    var channelImageName: String? {
        didSet {
            if let imageName = channelImageName {
                userProfileImageView.image = UIImage(named:  imageName)
            }
        }
    }
    
    var videoDescription: String? {
        didSet {
            if let channelName = videoDescription {
                subTitleTextView.text = channelName
            }
        }
    }
    
    var titleLabelHeigntConstraint: NSLayoutConstraint?
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_banner_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let userProfileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "taylor_profile_image")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 22
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blanck Space"
        return label
    }()
    
    private let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        textView.text = "TaylorSwiftVEVO - 1,604,684,607 views - 2 years ago"
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(separatorView)
        
        ///Setup Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        ///Setup Vertical Constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-24-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        setupTitleLabel()
        setupsubTitleTextView()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -16))
        
        //height constraint
        titleLabelHeigntConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeigntConstraint!)
    }
    
    private func setupsubTitleTextView() {
        addSubview(subTitleTextView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -16))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        
    }
    
}


//addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: .init(), metrics: nil, views: ["v0": thumbnailImageView]))
//addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: .init(), metrics: nil, views: ["v0": thumbnailImageView]))
//
//
//addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: .init(), metrics: nil, views: ["v0": separatorView]))
//addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: .init(), metrics: nil, views: ["v0": separatorView]))
