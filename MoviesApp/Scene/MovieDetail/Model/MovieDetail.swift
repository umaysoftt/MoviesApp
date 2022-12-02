//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var homepage: String?
    var id: Int?
    var imdbID, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
