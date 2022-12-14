//
//  NetworkConstans.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

class NetworkConstans {
    enum MovieServiceEndPoint: String {
        case BASEURL = "https://api.themoviedb.org/3/movie/"
        case APIKEY =  "5446b5c19e9238c6aac08e1b5a23c57a"
        case LANG = "&language=en-US"
        case UPCOMİNG = "upcoming"
        case IMAGEPATH = "https://image.tmdb.org/t/p/w500"
        case IMDB = "https://m.imdb.com/title/"
        case SEARCH = "https://api.themoviedb.org/3/search/movie"
        //https://api.themoviedb.org/3/?api_key=5446b5c19e9238c6aac08e1b5a23c57a&query=the+avengers
        //https://api.themoviedb.org/3/search/movie?api_key=5446b5c19e9238c6aac08e1b5a23c57a&query=the+avengers

        static func fetchUpComingMovies() -> String {
            "\(BASEURL.rawValue)\(UPCOMİNG.rawValue)?api_key=\(APIKEY.rawValue)\(LANG.rawValue)"
        }
        static func fetchDetailMovie(movieID: Int) -> String {
            "\(BASEURL.rawValue)/\(movieID)?api_key=\(APIKEY.rawValue)\(LANG.rawValue)"
        }
        static func fetchSearchMovies(movie: String) -> String {
            "\(SEARCH.rawValue)/?api_key=\(APIKEY.rawValue)&query=\(movie)"
        }

        static func getImage() -> String {
            "\(IMAGEPATH.rawValue)"
        }
        static func getIMDB() -> String {
            "\(IMDB.rawValue)"
        }
    }
}
