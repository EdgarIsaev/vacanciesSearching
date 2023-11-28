//
//  NetworkFetchData.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 26.11.2023.
//

import Foundation

class NetworkFetchData {
    
    static let shared = NetworkFetchData()
    private init(){}
    
    func fetchData(text: String, page: Int = 0, response: @escaping(Vacancies?, Error?) -> Void) {
         
        NetworkRequest.shared.requestData(requestText: text, page: page) { result in
            switch result {
                
            case .success(let data):
                do {
                    let vacancies = try JSONDecoder().decode(Vacancies.self, from: data)
                    response(vacancies, nil)
                } catch let jsonError {
                    print("Failed to json decode", jsonError)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil, error)
            }
        }
    }
}
