//
//  UIView_Extension.swift
//  Youtube
//
//  Created by Julio Collado on 12/15/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .init(), metrics: nil, views: viewDictionary))
    }
}
