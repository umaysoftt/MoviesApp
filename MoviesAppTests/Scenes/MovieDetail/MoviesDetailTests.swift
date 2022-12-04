//
//  MoviesDetailTests.swift
//  MoviesDetailTests
//
//  Created by İsmail Palalı on 3.12.2022.
//

import XCTest
@testable import MoviesApp

final class MoviesDetailTests: XCTestCase {


    var viewModel: MoviesDetailViewModel!
    var controller: MockMovieDetailViewController!
    var service: MockService!

    override func setUp() {
        super.setUp()
        controller = .init()
        service = .init()
        viewModel = .init(
            output: controller,
            service: service)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_getMovieDetail_Success_InvokedDisplayMovieDetail() {
        // Given
        let movieID = 123
        service.stubFetchMovieDetailCompletion = .init(id: movieID)

        // When
        viewModel.getMovieDetail(movieID)

        // Then
        XCTAssertTrue(controller.isDisplayMovieDetailCalled)
    }

    func test_getSimilarMovies_Success_InvokedDisplaySimilarMovies() {
        // Given
        let movieID = 123
        service.stubFetchSimilarMoviesCompletion = .init()

        // When
        viewModel.getSimilarMovies(movieID)

        // Then
        XCTAssertTrue(controller.isReloadListCalled)
    }
}


