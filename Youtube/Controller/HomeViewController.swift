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
    
    var videos: [Video] = []
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeViewControllerNavigationDelegate = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarButtons()
        setupMenuBar()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchVideos()
    }
    
    private func fetchVideos() {
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
        settingsLauncher.showSettings()
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
        //FIXME: - RedView to cover black space between the navBar and MenuBar when sliding occurs, not better solution founded for this issue
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        navigationController?.hidesBarsOnSwipe = true
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

extension HomeViewController: HomeViewControllerNavigationDelegate {
    func showViewController(for setting: SettingsMenuOptions) {
        if let navigationController = self.navigationController {
            NavigationBuilder.pushViewController(for: setting, on: navigationController)
        }
        
    }
}
