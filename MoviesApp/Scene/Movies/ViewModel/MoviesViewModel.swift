//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol MoviesViewModelOutput: AnyObject {
    func reloadList()
    func showErrorMessage(title:String,message:String)
    func showMovieDetail(_ movie: Movie)
}

final class MoviesViewModel {

    var datasourceUpcoming: [Movie] = []
    weak var output: MoviesViewModelOutput?
    private let service: ServiceProtocol

    // MARK: - Initialization
    init(service:  ServiceProtocol) {
        self.service = service
    }
}

// MARK: Events
extension MoviesViewModel {
    func getUpcomingList() {

        service.fetchUpcomingMovies { [weak self] response in
            guard let response = response else {
                self?.output?.showErrorMessage(title: "Error", message: ErrorTypes.generalError.rawValue)
                return}
            self?.datasourceUpcoming = response ?? []
            print(response)
            DispatchQueue.main.async {
                self?.output?.reloadList()
                }
            }
        }

    func searchMovie(movie: String) {
        service.fetchSearchMovies(movie: movie) { [weak self] response in
            guard let response = response else {
                self?.output?.showErrorMessage(title: "Error", message: ErrorTypes.generalError.rawValue)
                return}
            self?.datasourceUpcoming.removeAll()
            self?.datasourceUpcoming = response
            print(response)
            DispatchQueue.main.async {
                self?.output?.reloadList()
                }
            }
        }

    /// Select an item with IndexPath
    /// - Parameter indexPath: IndexPath of selected item
    func didSelectItemAtTableview(
        _ indexPath: IndexPath
    ) {
        let upcoming = datasourceUpcoming[indexPath.row]
        output?.showMovieDetail(upcoming)
    }
}

