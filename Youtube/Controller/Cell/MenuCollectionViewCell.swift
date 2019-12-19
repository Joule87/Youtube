//
//  MenuCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "MenuCollectionViewCell"
    let iconDefaultColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.tintColor = iconDefaultColor
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : iconDefaultColor
        }
    }
    
    override var isSelected: Bool {
         didSet {
             imageView.tintColor = isSelected ? UIColor.white : iconDefaultColor
         }
     }
    
    override func setupViews() {
        super.setupViews()
        setupImageView()
    }
    
    private func setupImageView(){
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
