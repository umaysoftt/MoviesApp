//
//  MoviesManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation


protocol MoviesManagerProtocol {
    func getCategoryMovies(type: MovieCategory, complete: @escaping((Movie?, Error?)->()))
}

final class MoviesManager: MoviesManagerProtocol {
    static let shared = MoviesManager()

    func getCategoryMovies(type: MovieCategory, complete: @escaping ((Movie?, Error?) -> ())) {
        var url = ""
        switch type {
        case .upcoming:
            url = MoviesHelper.upcoming.path
        }
        BaseNetworkManager.shared.request(type: Movie.self,
                                      url: url,
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

