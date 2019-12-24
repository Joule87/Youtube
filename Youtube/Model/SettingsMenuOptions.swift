//
//  SettingsMenuOptions.swift
//  Youtube
//
//  Created by Julio Collado on 12/22/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

enum SettingsMenuOptions: Int, CaseIterable {
    case Settings, Policy, Feedback, Help, SwitchAccount, Cancel
    
    var description: String {
        switch self {
            
        case .Settings:
            return "Settings"
        case .Policy:
            return "Terms & Privacy Policy"
        case .Feedback:
            return "Send Feedback"
        case .Help:
            return "Help"
        case .SwitchAccount:
            return "Switch Account"
        case .Cancel:
            return "Cancel"
        }
    }
    var image: UIImage {
        switch self {
            
        case .Settings:
            return #imageLiteral(resourceName: "settings")
        case .Policy:
            return #imageLiteral(resourceName: "privacy")
        case .Feedback:
            return #imageLiteral(resourceName: "feed-back")
        case .Help:
            return #imageLiteral(resourceName: "help")
        case .SwitchAccount:
            return #imageLiteral(resourceName: "switch-account")
        case .Cancel:
            return #imageLiteral(resourceName: "cancel")
        }
    }
}
