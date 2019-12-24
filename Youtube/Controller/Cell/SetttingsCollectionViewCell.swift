//
//  SetttingsCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/22/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class SetttingsCollectionViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier: String = "SetttingsCollectionViewCell"
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            iconImage.tintColor = isHighlighted ? .white : .black
            nameLabel.textColor = isHighlighted ? .white : .black
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImage: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = .black
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconImage)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(25)]-8-[v1]-16-|", views: iconImage, nameLabel)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: iconImage)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: nameLabel)
        
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
