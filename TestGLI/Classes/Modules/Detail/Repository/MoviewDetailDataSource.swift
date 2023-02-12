//
//  MoviewDetailDataSource.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import RxSwift

protocol MovieDetailDataSource {
    func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?>
    func getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?>
    func getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?>
    func getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?>
}
