//
//  HomeRepository.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import RxSwift

class HomeRepository: HomeDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func getMovies(request: MovieListRequest) -> Observable<MovieListModel?> {
        let url = APIUrl.movieList(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieListModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieListModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
    
    func searchMovies(request: MovieListRequest) -> Observable<MovieListModel?> {
        let url = APIUrl.searchMovieList(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<MovieListModel?> in
            do {
                let responseModel = try JSONDecoder().decode(MovieListModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
