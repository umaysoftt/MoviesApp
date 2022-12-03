//
//  MovieSimilarRequest.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

final class MovieSimilarRequest: BaseHelper {

    init(movieID: String) {
        super.init()
        let apiKey = NetworkConstans.MovieServiceEndPoint.APIKEY.rawValue
        let lang = NetworkConstans.MovieServiceEndPoint.LANG.rawValue
        path = "\(movieID)/similar?api_key=\(apiKey)\(lang)"
    }
}
