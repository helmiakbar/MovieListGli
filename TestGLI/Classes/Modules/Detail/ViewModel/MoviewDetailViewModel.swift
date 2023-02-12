//
//  MoviewDetailViewModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import RxSwift
import RxCocoa

class MovieDetailViewModel: BaseViewModel {
    private let dataSource: MovieDetailDataSource
    
    var movieDetailModel: MovieDetailResponseModel?
    var movieReviewModel: MovieReviewModel?
    var movieVideoModel: MovieVideoResponModel?
    var movieCreditModel: MovieCreditResponseModel?
    
    var request: MovieDetailRequest?
    
    init(dataSource: MovieDetailDataSource) {
        self.dataSource = dataSource
    }
    
    func loadMovieDetail() {
        self.state.accept(.loading)
        if let validRequest = request {
            let getMovieDetail = dataSource.getMovieDetail(request: validRequest)
            let getMovieVideo = dataSource.getMovieVideo(request: validRequest)
            let getMovieCredit = dataSource.getMovieCredit(request: validRequest)
            let getMovieReview = dataSource.getMovieReview(request: validRequest)
            
            Observable.zip(getMovieDetail, getMovieVideo, getMovieCredit, getMovieReview).map({
                if let movieDetail = $0.0 {
                    self.movieDetailModel = movieDetail
                }
                if let movieVideo = $0.1 {
                    self.movieVideoModel = movieVideo
                }
                if let movieCredit = $0.2 {
                    self.movieCreditModel = movieCredit
                }
                if let movieReview = $0.3 {
                    self.movieReviewModel = movieReview
                }
            }).subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.state.accept(.finished)
            }, onError: {[weak self] _ in
                guard let self = self else { return }
                self.state.accept(.failed)
            }).disposed(by: self.disposeBag)
        }
    }
}
