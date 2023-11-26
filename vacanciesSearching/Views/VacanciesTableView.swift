//
//  VacanciesTableView.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class VacanciesTableView: UITableView {
    
    private let idVacanciesTableViewCell = "idVacanciesTableViewCell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegates()
        register(VacanciesTableViewCell.self, forCellReuseIdentifier: idVacanciesTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9564198852, green: 0.9451850057, blue: 0.8892086744, alpha: 1)
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}

//MARK: UITableViewDataSource

extension VacanciesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idVacanciesTableViewCell, for: indexPath) as? VacanciesTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

//MARK: UITableViewDelegate

extension VacanciesTableView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        300
//    }
}


