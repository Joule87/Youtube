//
//  VideoPlayerView.swift
//  Youtube
//
//  Created by Julio Collado on 12/27/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    let controlsContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .init(white: 0, alpha: 1)
        return containerView
    }()
    
    let pausePlayButton: UIButton = {
        let pause = UIButton(type: UIButton.ButtonType.system)
        let image = UIImage(named: "pause")
        pause.setImage(image, for: .normal)
        pause.contentVerticalAlignment = .fill
        pause.contentHorizontalAlignment = .fill
        pause.tintColor = .white
        pause.isHidden = true
        pause.translatesAutoresizingMaskIntoConstraints = false
        pause.addTarget(self, action: #selector(handlePausePlay), for: .touchUpInside)
        return pause
    }()
    
    let videoLenghtLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        let dotImage = UIImage(named: "dot")
        slider.setThumbImage(dotImage, for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    var player: AVPlayer?
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePausePlay() {
        var image: UIImage?
        if isPlaying {
            player?.pause()
            image = UIImage(named: "play")
        } else {
            player?.play()
            image = UIImage(named: "pause")
        }
        pausePlayButton.setImage(image, for: .normal)
        isPlaying = !isPlaying
    }
    
    func setupViews() {
        setupPlayerView()
        setupControlContainer()
        setupGradientLayer()
    }
    
    @objc func handleSliderChange() {
        guard let duration = player?.currentItem?.duration else {
            return
        }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = videoSlider.value * Float(totalSeconds)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            //do something
        })
    }
    
    func setupGradientLayer() {
        let gradienteLayer = CAGradientLayer()
        gradienteLayer.frame = bounds
        gradienteLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradienteLayer.locations = [0.85, 1.2]
        controlsContainerView.layer.addSublayer(gradienteLayer)
    }
    
    func setupControlContainer() {
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(videoLenghtLabel)
        [videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
         videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
         videoLenghtLabel.widthAnchor.constraint(equalToConstant: 60),
         videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24)].forEach{$0.isActive = true}
        
        controlsContainerView.addSubview(currentTimeLabel)
        [currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
         currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
         currentTimeLabel.widthAnchor.constraint(equalToConstant: 60),
         currentTimeLabel.heightAnchor.constraint(equalToConstant: 24)].forEach{$0.isActive = true}
        
        controlsContainerView.addSubview(videoSlider)
        [videoSlider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor),
         videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
         videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor),
         videoSlider.heightAnchor.constraint(equalToConstant: 30)].forEach{$0.isActive = true}
        
    }
    
    fileprivate func setupPlayerView() {
        backgroundColor = .black
        let urlString = "https://thumbs.gfycat.com/HealthyFaintBilby-mobile.mp4"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            let timeInterval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main, using: { progressTime in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                self.currentTimeLabel.text = "\(minutesText):\(secondsText)"
                guard let duration = self.player?.currentItem?.duration else {
                    return
                }
                let durationInSeconds = CMTimeGetSeconds(duration)
                self.videoSlider.value = Float(seconds / durationInSeconds)
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = String(format: "%02d",  Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLenghtLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
}

