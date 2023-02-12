//
//  HomeDataSource.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import RxSwift

protocol HomeDataSource {
    func getMovies(request: MovieListRequest) -> Observable<MovieListModel?>
    func searchMovies(request: MovieListRequest) -> Observable<MovieListModel?>
}
