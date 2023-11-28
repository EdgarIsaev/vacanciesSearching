//
//  String + Extensions.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 27.11.2023.
//

import Foundation

extension String {
    public func trimHTMLTags() -> String {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else { return "--" }
    
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
    
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string ?? "--"
    }
}
