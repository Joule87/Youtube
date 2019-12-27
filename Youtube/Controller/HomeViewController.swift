//
//  CollectionViewController.swift
//  Youtube
//
//  Created by Julio Collado on 12/15/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.delegate = self
        return menu
    }()
    
    private let menuBarHeight: CGFloat = 50
    
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
        self.collectionView!.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        self.collectionView!.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.trendingCellIdentifier)
        self.collectionView!.register(SubscriptionsCollectionViewCell.self, forCellWithReuseIdentifier: SubscriptionsCollectionViewCell.subscriptionsCellIdentifier)
        self.collectionView!.register(LibraryCollectionViewCell.self, forCellWithReuseIdentifier: LibraryCollectionViewCell.libraryCollectionCellIdentifier)
        
        //Make collectionView elements visible under MenuBar
        
        self.collectionView.contentInset = UIEdgeInsets(top: menuBarHeight, left: 0, bottom: 0, right: 0)
        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: menuBarHeight, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.isPrefetchingEnabled = false
        collectionView.isPagingEnabled = true
    }
    
    private func setupMenuBar(){
        //FIXME: - RedView to cover black space between the navBar and MenuBar when sliding occurs, not better solution founded for this issue
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(\(menuBarHeight))]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(\(menuBarHeight))]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        var title: String?
        if let index = menuBar.collectionView.indexPathsForSelectedItems?.first {
            title = MenuBarOptions(rawValue: index.row)?.description
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.titleView = titleLabel
        //Get rid of gray line underneath navigationBar
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuBarOptions.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier: String = ""
        
        switch indexPath.row {
        case 0:
            identifier = FeedCollectionViewCell.identifier
        case 1:
            identifier = TrendingCollectionViewCell.trendingCellIdentifier
        case 2:
            identifier = SubscriptionsCollectionViewCell.subscriptionsCellIdentifier
        case 3:
            identifier = LibraryCollectionViewCell.libraryCollectionCellIdentifier
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftanchorConstraint?.constant = scrollView.contentOffset.x/CGFloat(MenuBarOptions.allCases.count)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        updateNavigationTitle(at: index)
    }
    
    func updateNavigationTitle(at index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel, let menuTitle = MenuBarOptions(rawValue: index)?.description {
            titleLabel.text = menuTitle
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - menuBarHeight)
    }
    
}

extension HomeViewController: HomeViewControllerNavigationDelegate {
    func showViewController(for setting: SettingsMenuOptions) {
        if let navigationController = self.navigationController {
            NavigationBuilder.pushViewController(for: setting, on: navigationController)
        }
        
    }
}

extension HomeViewController: MenuBarParentDelegate {
    func scrollToMenuIndex(menuIndex: Int) {
        updateNavigationTitle(at: menuIndex)
        let indexPath = IndexPath(row: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
}
