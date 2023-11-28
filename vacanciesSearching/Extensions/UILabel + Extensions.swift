//
//  UILabel + Extensions.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "", font: UIFont, textColor: UIColor, lines: Int = 0) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.lineBreakMode = .byWordWrapping
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.numberOfLines = lines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
