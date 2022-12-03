//
//  BaseHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class BaseHelper {
    static let shared = BaseHelper()

    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "5446b5c19e9238c6aac08e1b5a23c57a"
    private let imageBasePath = "https://image.tmdb.org/t/p/original/"

    func requestUrl(url: String) -> String {
        baseURL + url + "?api_key=\(apiKey)"
    }

    func getImagePath(url: String) -> String {
        imageBasePath + url
    }
}

