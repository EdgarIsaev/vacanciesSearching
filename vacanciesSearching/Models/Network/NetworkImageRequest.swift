//
//  NetworkImageRequest.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 26.11.2023.
//

import Foundation

class NetworkImageRequest {
     
    static let shared = NetworkImageRequest()
    private init(){}
    
    func imageFetch(imageUrl: String, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
                guard let data = data else{ return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
