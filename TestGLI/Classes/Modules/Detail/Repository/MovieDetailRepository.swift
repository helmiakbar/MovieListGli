//
//  MovieDetailRepository.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import RxSwift

class MovieDetailRepository: MovieDetailDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func getMovieDetail(request: MovieDetailRequest) -> Observable<MovieDetailResponseModel?> {
        let url = APIUrl.movieDetail(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieDetailResponseModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieDetailResponseModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func getMovieReview(request: MovieDetailRequest) -> Observable<MovieReviewModel?> {
        let url = APIUrl.movieReview(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieReviewModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieReviewModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func getMovieVideo(request: MovieDetailRequest) -> Observable<MovieVideoResponModel?> {
        let url = APIUrl.movieVideo(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieVideoResponModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieVideoResponModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func getMovieCredit(request: MovieDetailRequest) -> Observable<MovieCreditResponseModel?> {
        let url = APIUrl.movieCredit(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieCreditResponseModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieCreditResponseModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
