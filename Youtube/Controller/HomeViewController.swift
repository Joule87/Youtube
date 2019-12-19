//
//  CollectionViewController.swift
//  Youtube
//
//  Created by Julio Collado on 12/15/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    let menuBar: MenuBar = {
        let menu = MenuBar()
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMenuBar()
        setupCollectionView()

    }
    
    private func setupCollectionView() {
        // Register cell classes
        self.collectionView!.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
        
        //Make collectionView elements visible under MenuBar
        let menuBarHeight: CGFloat = 50
        self.collectionView.contentInset = UIEdgeInsets(top: menuBarHeight, left: 0, bottom: 0, right: 0)
        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: menuBarHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        navigationItem.titleView = titleLabel
        
        //Get rid of gray line underneath navigationBar
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftCellSpace = CGFloat(16)
        let rightCellSpace = CGFloat(16)
        let thumbnailImageheight = (view.frame.width - leftCellSpace - rightCellSpace) * 9/16
        
        let subtitleBottonSpace = CGFloat(16)
        let userProfileImageViewTopSpace = CGFloat(8)
        let userProfileImageViewHeight = CGFloat(44)
        let userProfileImageViewBottomSpace = CGFloat(16)
        let separatorViewHeight = CGFloat(1)
        
        let cellHeight = thumbnailImageheight + subtitleBottonSpace + userProfileImageViewTopSpace + userProfileImageViewHeight + userProfileImageViewBottomSpace + separatorViewHeight
        
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
