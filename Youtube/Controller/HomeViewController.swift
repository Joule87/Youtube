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
    
    var videos: [Video] = {
        var goku = Channel()
        goku.name = "DBZ"
        goku.profileImageName = "goku"
        
        var taylor = Channel()
        taylor.name = "Taylor Company"
        taylor.profileImageName = "taylor_profile_image"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thimbnailImageName = "taylor_banner_image"
        blankSpaceVideo.channel = goku
        blankSpaceVideo.numberOfViews = 1230435
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBloodVideo.thimbnailImageName = "taylor_badBlood_banner"
        badBloodVideo.channel = taylor
        badBloodVideo.numberOfViews = 5000123
        
        return [blankSpaceVideo, badBloodVideo]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarButtons()
        setupMenuBar()
        setupCollectionView()
        
    }
    
    private func setupNavigationBarButtons() {
        let searchImage = #imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate)
        let searchImageButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        searchImageButton.tintColor = .white
        
        let moreBurtton = #imageLiteral(resourceName: "more").withRenderingMode(.alwaysTemplate)
        let moreImageButton = UIBarButtonItem(image: moreBurtton, style: .plain, target: self, action: #selector(handleMore))
        moreImageButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [moreImageButton, searchImageButton]
    }
    
    @objc func handleSearch() {
        print("asd")
    }
    
    @objc func handleMore() {
        print("123")
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
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        cell.thumbnailImageName = videos[indexPath.row].thimbnailImageName
        cell.title = videos[indexPath.row].title
        cell.channelImageName = videos[indexPath.row].channel?.profileImageName
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        if let channelName = videos[indexPath.row].channel?.name,
            let numberOfViews = videos[indexPath.row].numberOfViews,
            let numberOfViewsFormatted = numberFormatter.string(from: numberOfViews) {
            
            cell.videoDescription = "\(channelName) • \(numberOfViewsFormatted) • 2 years ago"
        }
        
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
