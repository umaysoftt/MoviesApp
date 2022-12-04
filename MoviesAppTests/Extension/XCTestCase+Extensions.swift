//
//  XCTestCase+Extensions.swift
//  MoviesAppTests
//
//  Created by İsmail Palalı on 4.12.2022.
//

import XCTest

extension XCTestCase {
    func delay(timeout: Double) {
        let expectation = XCTestExpectation(
            description: "Delay"
        )
        DispatchQueue.main.asyncAfter(
            deadline: .now() + timeout) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 100000)
    }
}
