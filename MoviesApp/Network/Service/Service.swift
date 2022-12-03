//
//  Service.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation
import Alamofire

// MARK: - Services Protocol
protocol ServiceProtocol {
    func fetchUpcomingMovies(completion: @escaping ([Movie]?) -> Void)
    func fetchMovieDetail(movieID:Int,completion: @escaping (MovieDetailModel?) -> Void)
}

// MARK: - Services
final class Services: ServiceProtocol {
    func fetchMovieDetail(movieID: Int, completion: @escaping (MovieDetailModel?) -> Void) {
        let request = MovieDetailRequest(movieID: movieID.stringValue)
        BaseNetworkManager.shared.load(request: request, responseType: MovieDetailModel.self) { result in
            switch result {
            case .success(let data):
                completion(data)
                return
            case .failure(let err):
                print("err: ", err.localizedDescription)
            }
        }
    }

    func fetchUpcomingMovies(completion: @escaping ([Movie]?) -> Void) {
        let request = MovieUpcomingRequest()
        BaseNetworkManager.shared.load(request: request, responseType: MoviesResponse.self) { result in
            switch result {
            case .success(let data):
                completion(data?.movies)
                return
            case .failure(let err):
                print("err: ", err.localizedDescription)
            }
        }
    }
}

