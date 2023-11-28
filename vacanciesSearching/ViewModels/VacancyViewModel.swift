//
//  VacancyViewModel.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 26.11.2023.
//

import Foundation
import Combine


class VacancyViewModel {
    @Published var vacancies = [VacancyModel]()
    @Published var searchText = ""
    
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{ [weak self] text in
                if text.count >= 3 {
                    self?.vacancies.removeAll()
                    NetworkFetchData.shared.fetchData(text: text) { [weak self] data, error in
                        guard let self = self else { return }
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        guard let data = data else { return }
                        self.vacancies.append(contentsOf: data.items)
                    } 
                } else if text.isEmpty {
                    self?.vacancies.removeAll()
                }
            }
            .store(in: &cancellables)
    }
}
