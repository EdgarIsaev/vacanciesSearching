//
//  UIStackView + Extensions.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self .init(arrangedSubviews: arrangedSubViews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = .leading
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
