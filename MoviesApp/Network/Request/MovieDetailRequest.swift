//
//  MovieDetailHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

final class MovieDetailRequest: BaseHelper {

    init(movieID: String) {
        super.init()
        let apiKey = NetworkConstans.MovieServiceEndPoint.APIKEY.rawValue
        let lang = NetworkConstans.MovieServiceEndPoint.LANG.rawValue
        path = "\(movieID)?api_key=\(apiKey)\(lang)"
    }
}

