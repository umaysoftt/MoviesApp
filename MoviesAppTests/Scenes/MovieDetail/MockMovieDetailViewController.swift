//
//  MockMovieDetailViewController.swift
//  MoviesAppTests
//
//  Created by İsmail Palalı on 4.12.2022.
//

@testable import MoviesApp

final class MockMovieDetailViewController: MoviesDetailViewModelOutput {
    
    var isShowErrorMessageCalled: Bool = false
    func showErrorMessage(title: String, message: String) {
        isShowErrorMessageCalled = true
    }

    var isReloadListCalled: Bool = false
    func reloadList() {
        isReloadListCalled = true
    }
    
    var isDisplayMovieDetailCalled: Bool = false
    func displayMovieDetail(_ movie: MovieDetailModel) {
        isDisplayMovieDetailCalled = true
    }
}
