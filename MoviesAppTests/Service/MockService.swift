//
//  MockService.swift
//  MoviesAppTests
//
//  Created by İsmail Palalı on 4.12.2022.
//

@testable import MoviesApp

final class MockService: ServiceProtocol {

    var stubFetchUpcomingMoviesCompletion: [Movie]?
    func fetchUpcomingMovies(completion: @escaping ([Movie]?) -> Void) {
        completion(stubFetchUpcomingMoviesCompletion)
    }

    var stubFetchSimilarMoviesCompletion: [Movie]?
    func fetchSimilarMovies(movieID: Int, completion: @escaping ([Movie]?) -> Void) {
        completion(stubFetchSimilarMoviesCompletion)
    }

    var stubFetchSearchMoviesCompletion: [Movie]?
    func fetchSearchMovies(movie: String, completion: @escaping ([Movie]?) -> Void) {
        completion(stubFetchSearchMoviesCompletion)
    }

    var stubFetchMovieDetailCompletion: MovieDetailModel?
    func fetchMovieDetail(movieID: Int, completion: @escaping (MovieDetailModel?) -> Void) {
        completion(stubFetchMovieDetailCompletion)
    }
}
