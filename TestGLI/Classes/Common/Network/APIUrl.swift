//
//  APIUrl.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import Foundation

enum APIUrl {
    case movieList(request: MovieListRequest)
    case searchMovieList(request: MovieListRequest)
    case movieDetail(request: MovieDetailRequest)
    case movieReview(request: MovieDetailRequest)
    case movieVideo(request: MovieDetailRequest)
    case movieCredit(request: MovieDetailRequest)
    
    func apiString() -> String {
        switch self {
        case .movieList(request: let request):
            return "3/movie/now_playing?\(request.getParams().toQueryString())"
        case .searchMovieList(request: let request):
            return "3/search/movie?\(request.getParamsSearch().toQueryString())"
        case .movieDetail(request: let request):
            return "3/movie/\(request.movieId)?\(request.getParams().toQueryString())"
        case .movieReview(request: let request):
            return "3/movie/\(request.movieId)/reviews?\(request.getParams().toQueryString())"
        case .movieVideo(request: let request):
            return "3/movie/\(request.movieId)/videos?\(request.getParams().toQueryString())"
        case .movieCredit(request: let request):
            return "3/movie/\(request.movieId)/credits?\(request.getParams().toQueryString())"
        }
    }
    
    func urlString() -> String {
        return NetworkConfiguration.api(self)
    }
}
