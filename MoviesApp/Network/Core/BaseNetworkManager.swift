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

    func load<T: Decodable>(
        request: BaseHelper,
        responseType: T.Type,
        completion: @escaping (Result<T?, ErrorTypes>) -> Void) {
            AF
                .request(request.url)
                .responseDecodable(of: T.self
                ) { result in
                    DispatchQueue.main.async {
                        switch result.result {
                        case .success(let data):
                            completion(.success(data))
                            return
                        case .failure(let err):
                            completion(.failure(.generalError))
                        }
                    }
                }
        }

    func search<T: Decodable>(
        request: BaseHelper,
        responseType: T.Type,
        completion: @escaping (Result<T?, ErrorTypes>) -> Void) {
            AF
                .request(request.urlSearch)
                .responseDecodable(of: T.self
                ) { result in
                    DispatchQueue.main.async {
                        switch result.result {
                        case .success(let data):
                            completion(.success(data))
                            return
                        case .failure(let err):
                            completion(.failure(.generalError))
                        }
                    }
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


