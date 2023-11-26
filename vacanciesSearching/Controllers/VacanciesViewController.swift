//
//  VacanciesViewController.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class VacanciesViewController: UIViewController {
    
    private let searchingTextField = SearchingTextField()
    
    private let vacanciesTableView = VacanciesTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addSubviews()
        setConstraints()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.9564198852, green: 0.9451850057, blue: 0.8892086744, alpha: 1)
    }
    
    private func addSubviews() {
        view.addSubview(searchingTextField)
        view.addSubview(vacanciesTableView)
    }

}

//MARK: SetConstraints

extension VacanciesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            searchingTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchingTextField.heightAnchor.constraint(equalToConstant: 40),
            
            vacanciesTableView.topAnchor.constraint(equalTo: searchingTextField.bottomAnchor, constant: 10),
            vacanciesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vacanciesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vacanciesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

