//
//  VacanciesTableView.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class VacanciesTableView: UITableView {

    private var vacancies = [VacancyModel]()
    private var page = 0
    private var searchingText = ""
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
    
    private func fetchMoreData() {
        page += 1
        
        NetworkFetchData.shared.fetchData(text: searchingText, page: page) { [weak self] data, error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            self.vacancies.append(contentsOf: data.items)
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    public func getVacancies(vacancies: [VacancyModel]) {
        self.vacancies = vacancies
        page = 0
    }
    
    public func getText(text: String) {
        searchingText = text
    }
}

//MARK: UITableViewDataSource

extension VacanciesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idVacanciesTableViewCell, for: indexPath) as? VacanciesTableViewCell else { return UITableViewCell() }
        
        
        let model = vacancies[indexPath.row]
        cell.setupViews(model: model)
        
        return cell
    }
    
    
}

//MARK: UITableViewDelegate

extension VacanciesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

//MARK: UIScrollViewDelegate

extension VacanciesTableView: UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == vacancies.count - 6 {
            fetchMoreData()
        }
    }
}


