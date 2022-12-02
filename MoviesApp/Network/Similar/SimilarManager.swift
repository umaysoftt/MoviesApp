//
//  SimilarManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol SimilarManagerManagerProtocol {
    func getSimilarMovies(id: Int, complete: @escaping((Movie?, Error?)->()))
}

final class SimilarManager: SimilarManagerManagerProtocol {
    static let shared = SimilarManager()

    func getSimilarMovies(id: Int, complete: @escaping ((Movie?, Error?) -> ())) {
        BaseNetworkManager.shared.request(type: Movie.self,
                                      url: SimilarHelperHelperEndpoint.similar.path + "\(id)/similar",
                                      method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
