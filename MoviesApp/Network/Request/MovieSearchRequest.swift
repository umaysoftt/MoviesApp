//
//  MovieSearchRequest.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

final class MovieSearchRequest: BaseHelper {

    init(movie: String) {
        super.init()
        let apiKey = NetworkConstans.MovieServiceEndPoint.APIKEY.rawValue
        path = "?api_key=\(apiKey)&query=\(movie)"
    }
}
