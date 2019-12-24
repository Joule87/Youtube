//
//  NavigationBuilder.swift
//  Youtube
//
//  Created by Julio Collado on 12/23/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

struct NavigationBuilder {
    
    static func pushViewController(for setting: SettingsMenuOptions, on navigationController: UINavigationController) {
        var viewControllerToPush = UIViewController()
        switch setting {
        case .Settings:
            viewControllerToPush = SettingsViewController()
        case .Policy:
            viewControllerToPush = PolicyViewController()
        case .Feedback:
            viewControllerToPush = FeedbackViewController()
        case .Help:
            viewControllerToPush = HelpViewController()
        case .SwitchAccount:
            viewControllerToPush = SwitchAccountViewController()
        case .Cancel:
            return
        }
        navigationController.pushViewController(viewControllerToPush, animated: true)
    }
    
}
