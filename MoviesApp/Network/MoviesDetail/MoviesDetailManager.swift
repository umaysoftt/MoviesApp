//
//  MoviesDetailManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation
import Alamofire

protocol MoviesDetailManagerProtocol {
    func getDetailMovie(movieID: Int, completion: @escaping((MovieDetailModel?, AFError?)->()))
}

final class MoviesDetailManager: MoviesDetailManagerProtocol {
    static let shared = MoviesDetailManager()

    func getDetailMovie(movieID: Int, completion: @escaping ((MovieDetailModel?, AFError?) -> ())) {
        let request = MovieDetailRequest(movieID: movieID.stringValue)
        BaseNetworkManager.shared.load(request: request, responseType: MovieDetailModel.self) { result in
            switch result {
            case .success(let data):
                completion(data,nil)
                return
            case .failure(let err):
                print("err: ", err.localizedDescription)
            }
        }
    }
}

