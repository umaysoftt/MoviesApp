//
//  MoviesDetailViewModel.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol MoviesDetailViewModelOutput: AnyObject {
    func displayProductDetail(_ movie: MovieDetailModel)
    func showErrorMessage(title:String,message:String)
}

final class MoviesDetailViewModel {
    private weak var output: MoviesDetailViewModelOutput?
    private let service: MoviesDetailManager

    // MARK: - Initialization
    init(output: MoviesDetailViewModelOutput,
         service: MoviesDetailManager) {
        self.output = output
        self.service = service
    }
}

// MARK: Events
extension MoviesDetailViewModel {
    func getProductDetail(
        _ movieID: Int
    ) {
        service.getDetailMovie(movieID: movieID) { [weak self] response,error in
            guard let response = response else {
                self?.output?.showErrorMessage(title: "Error", message: ErrorTypes.generalError.rawValue)
                return }
            self?.output?.displayProductDetail(response)
        }
    }
}

