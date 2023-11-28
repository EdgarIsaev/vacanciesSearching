//
//  NetworkRequest.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 26.11.2023.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init(){}
    
    func requestData(requestText: String, page: Int, completion: @escaping(Result<Data, Error>) -> Void ) {
        
        guard let text = requestText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let urlString = "https://api.hh.ru/vacancies/?text=\(text)&per_page=20&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
