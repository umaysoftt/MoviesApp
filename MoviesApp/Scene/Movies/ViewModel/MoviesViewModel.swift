//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol MoviesViewModelOutput: AnyObject {
    func reloadList()
    func showProductDetail(_ movie: MovieResult)
}

final class MoviesViewModel {

    var datasourceUpcoming: [MovieResult] = []
    weak var output: MoviesViewModelOutput?
    private let service: MoviesManager

    // MARK: - Initialization
    init(service:  MoviesManager) {
        self.service = service
    }
}

// MARK: Events
extension MoviesViewModel {

    func getUpcomingList() {

        service.getCategoryMovies(type: .upcoming) { [weak self] response, error in
            guard let response = response else {return}
            self?.datasourceUpcoming = response.results ?? []
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
        output?.showProductDetail(upcoming)
    }
}

