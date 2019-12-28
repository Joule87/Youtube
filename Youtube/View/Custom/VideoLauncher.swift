//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Julio Collado on 12/27/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class VideoLauncher {
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height, width: 0, height: 0)
            let view = UIView(frame: frame)
            view.backgroundColor = .white
            
            let height: CGFloat = keyWindow.frame.width * 9/16
            let videoFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoFrame)
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                view.frame = keyWindow.frame
            }) { (isCompleted) in
                UIApplication.shared.keyWindow?.windowLevel = .statusBar
            }
        }
    }
}

