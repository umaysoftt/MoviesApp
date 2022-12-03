//
//  MoviesDetailViewModel.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol MoviesDetailViewModelOutput: AnyObject {
    func displayMovieDetail(_ movie: MovieDetailModel)
    func showErrorMessage(title:String,message:String)
    func reloadList()
}

final class MoviesDetailViewModel {
    private weak var output: MoviesDetailViewModelOutput?
    private let service: ServiceProtocol
    var similarMovies: [Movie] = []

    // MARK: - Initialization
    init(output: MoviesDetailViewModelOutput,
         service: ServiceProtocol) {
        self.output = output
        self.service = service
    }
}

// MARK: Events
extension MoviesDetailViewModel {
    func getMovieDetail(
        _ movieID: Int
    ) {
        service.fetchMovieDetail(movieID: movieID) { [weak self] response in
            guard let response = response else {
                self?.output?.showErrorMessage(title: "Error", message: ErrorTypes.generalError.rawValue)
                return }
            self?.output?.displayMovieDetail(response)
        }
    }

    func getSimilarMovies(_ movieID: Int) {
        service.fetchSimilarMovies(movieID: movieID) { [weak self] response in
            guard let response = response else {
                self?.output?.showErrorMessage(title: "Error", message: ErrorTypes.generalError.rawValue)
                return }
            self?.similarMovies = response
            self?.output?.reloadList()
            print(response)
        }

    }
}

