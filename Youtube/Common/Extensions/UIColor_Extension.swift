//
//  UIColor_Extension.swift
//  Youtube
//
//  Created by Julio Collado on 12/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
