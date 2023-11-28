//
//  VacanciesViewController.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit
import Combine

class VacanciesViewController: UIViewController {
    
    private let searchingTextField = SearchingTextField()
    private let vacanciesTableView = VacanciesTableView()
    private let isEmptyLabel = UILabel(text: "Введите в поиск название и появится список вакансий",
                                    font: .systemFont(ofSize: 20, weight: .light),
                                    textColor: .gray)
    
    private let viewModel = VacancyViewModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addSubviews()
        bindViewModel()
        bindTableView()
        getText()
        addGesture()
        setConstraints()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.9564198852, green: 0.9451850057, blue: 0.8892086744, alpha: 1)
        
        vacanciesTableView.tableViewDelegate = self
        searchingTextField.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(searchingTextField)
        view.addSubview(isEmptyLabel)
        view.addSubview(vacanciesTableView)
    }
    
    private func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: searchingTextField)
            .map { ($0.object as! UITextField).text ?? ""}
            .assign(to: \.searchText, on: viewModel)
            .store(in: &cancellable)
    }
    
    private func bindTableView() {
        viewModel.$vacancies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vacancy in
                guard let self = self else { return }
                self.vacanciesTableView.getVacancies(vacancies: vacancy)
                self.vacanciesTableView.reloadData()
                self.vacanciesTableView.isHidden = vacancy.isEmpty
                self.isEmptyLabel.isHidden = !vacancy.isEmpty
            }
            .store(in: &cancellable)
    }
    
    private func getText() {
        viewModel.$searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.vacanciesTableView.getText(text: text)
            }
            .store(in: &cancellable)

    }
    
    private func addGesture() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: VacanciesTableViewProtocol

extension VacanciesViewController: VacanciesTableViewProtocol {
    func selectedCell(index: IndexPath) {
        vacanciesTableView.cellForRow(at: index)?.isSelected = true
    }
    
    func deselectedCell(index: IndexPath) {
        vacanciesTableView.cellForRow(at: index)?.isSelected = false
    }
}

//MARK: UITextFieldDelegate

extension VacanciesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchingTextField.resignFirstResponder()
        return true
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
            
            isEmptyLabel.topAnchor.constraint(equalTo: searchingTextField.bottomAnchor, constant: 20),
            isEmptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            isEmptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            vacanciesTableView.topAnchor.constraint(equalTo: searchingTextField.bottomAnchor, constant: 10),
            vacanciesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vacanciesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vacanciesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}



