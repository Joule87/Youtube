//
//  LibraryCollectionViewCell.swift
//  Youtube
//
//  Created by Julio Collado on 12/26/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class LibraryCollectionViewCell: FeedCollectionViewCell {
    static let libraryCollectionCellIdentifier =  "LibraryCollectionViewCell"
    
    override func fetchVideos() {
         print("Make LibraryCollectionViewCell request")
    }
}
