//
//  SearchingTextField.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class SearchingTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1, green: 0.3394592702, blue: 0.4258575439, alpha: 1)
        layer.cornerRadius = 10
        textColor = .black
        leftView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 15,
                                        height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        placeholder = "Введите ваш запрос"
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
