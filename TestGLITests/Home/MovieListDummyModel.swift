//
//  MovieListDummyModel.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

import Foundation
@testable import TestGLI
import RxSwift

struct MovieListDummyModel {
    let dummyInt = Int.random(in: 0...100)
    let dummyString = UUID().uuidString
    let dummyBool = Bool.random()
    let dummyDouble = Double.random(in: 0...100)
    
    func getMovieListModel() -> MovieListModel {
        return MovieListModel(dates: MovieListModel.Dates(maximum: dummyString, minimum: dummyString), page: dummyInt, total_pages: dummyInt, total_results: dummyInt, results: [MovieListModel.Datum(adult: dummyBool, backdrop_path: dummyString, genre_ids: [dummyInt], id: dummyInt, original_language: dummyString, original_title: dummyString, overview: dummyString, popularity: dummyDouble, poster_path: dummyString, release_date: dummyString, title: dummyString, video: dummyBool, vote_average: dummyDouble, vote_count: dummyInt)])
    }
}
