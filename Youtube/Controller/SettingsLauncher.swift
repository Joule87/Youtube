//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Julio Collado on 12/22/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    var homeViewControllerNavigationDelegate: HomeViewControllerNavigationDelegate?
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    private let cellHeight: CGFloat = 50
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SetttingsCollectionViewCell.self, forCellWithReuseIdentifier: SetttingsCollectionViewCell.reuseIdentifier)
    }
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(SettingsMenuOptions.allCases.count) * self.cellHeight
            let y = window.frame.size.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.size.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            })
            
        }
    }
    
    @objc private func didTapDismiss() {
        dismissSettingsMenu {
            self.removeSettingMenuViews()
        }
    }
    
    private func dismissSettingsMenu(with completion: (()->Void)? = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let height: CGFloat = CGFloat(SettingsMenuOptions.allCases.count) * self.cellHeight
                self.collectionView.frame = CGRect(x: 0, y: window.frame.size.height, width: self.collectionView.frame.width, height: height)
            }
        }) { (_) in
            if let complete = completion {
                complete()
            }
            
        }
    }
    
    private func removeSettingMenuViews() {
        self.blackView.removeFromSuperview()
        self.collectionView.removeFromSuperview()
    }
}

extension SettingsLauncher: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingsMenuOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SetttingsCollectionViewCell.reuseIdentifier, for: indexPath) as! SetttingsCollectionViewCell
        cell.iconImage.image = SettingsMenuOptions(rawValue: indexPath.row)?.image
        cell.nameLabel.text = SettingsMenuOptions(rawValue: indexPath.row)?.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let option = SettingsMenuOptions(rawValue: indexPath.row) else { return }
        dismissSettingsMenu() {
            self.removeSettingMenuViews()
            if option != .Cancel{
                self.homeViewControllerNavigationDelegate?.showViewController(for: option)
            }
            
        }
        
    }
    
}

