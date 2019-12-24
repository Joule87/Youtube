//
//  BaseCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
