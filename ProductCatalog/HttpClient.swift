//
//  HttpClient.swift
//  ProductCatalog
//
//  Created by Ahmet SIRMA on 13.10.2022.
//

import Foundation

enum NetworkResponse<T, U: Error> {
    
    case success(T)
    case failure(U)
    
}

enum NetworkError: Error {
    case network
    case decoding

    var errorMessage: String {
        switch self {
        case .network:
            return "Fetching Error Occured."
        case .decoding:
            return "Decoding Error Occured."
        }
    }
}

class HttpClient {
    static func sendRequest<T: Decodable>(url: String, completion: @escaping (NetworkResponse<T, NetworkError>) -> Void) {
        if let url = URL(string: url) {
            print("url:\(url)")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(NetworkResponse.failure(.network))
                }
                if let receivedData = data {
                    if let decodedData = try? JSONDecoder().decode(T.self, from: receivedData) {
                        completion(NetworkResponse.success(decodedData))
                    }
                    else {
                        completion(NetworkResponse.failure(.decoding))
                    }
                }
            }.resume()
        }
    }
    
    static func sendDataRequest(url: String, completion: @escaping (NetworkResponse<Data, NetworkError>) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(NetworkResponse.failure(.network))
                }
                if let receivedData = data {
                    completion(NetworkResponse.success(receivedData))
                }
                else {
                    completion(NetworkResponse.failure(.network))
                }
            }.resume()
        }
    }
}
