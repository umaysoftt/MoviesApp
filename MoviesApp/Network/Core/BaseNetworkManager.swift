//
//  BaseNetworkManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation
import Alamofire

import Alamofire

class BaseNetworkManager {
    static let shared = BaseNetworkManager()

    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethod,
                             completion: @escaping((Result<T, ErrorTypes>)->())) {
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", method: method).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
            case .failure(let _):
                completion(.failure(.generalError))
            }
        }
    }

    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}

