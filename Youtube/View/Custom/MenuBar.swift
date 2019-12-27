//
//  MenuBar.swift
//  Youtube
//
//  Created by Julio Collado on 12/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
   var delegate: MenuBarParentDelegate?
    var horizontalBarLeftanchorConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupHorizontalWhiteBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHorizontalWhiteBar(){
        let horizontalBarView = UIView()
        horizontalBarView.layer.cornerRadius = 1
        horizontalBarView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftanchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
            
        [horizontalBarLeftanchorConstraint!,
         horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4), horizontalBarView.heightAnchor.constraint(equalToConstant: 5)].forEach{ $0.isActive = true }
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        
        //highlight first element at the MenuBar
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuBarOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
        let image = MenuBarOptions(rawValue: indexPath.row)?.image
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/CGFloat(MenuBarOptions.allCases.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         delegate?.scrollToMenuIndex(menuIndex: indexPath.row)
    }
    
}
