//
//  MoviesDetailManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol MoviesDetailManagerProtocol {
    func getDetailMovie(id: Int, complete: @escaping((MovieDetailModel?, Error?)->()))
}

final class MoviesDetailManager: MoviesDetailManagerProtocol {
    static let shared = MoviesDetailManager()

    func getDetailMovie(id: Int, complete: @escaping ((MovieDetailModel?, Error?) -> ())) {
        BaseNetworkManager.shared.request(type: MovieDetailModel.self,
                                      url: MovieDetailHelperEndpoint.detail.path + "\(id)",
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

