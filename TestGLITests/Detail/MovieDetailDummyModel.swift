//
//  MovieDetailDummyModel.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

import Foundation
@testable import TestGLI
import RxSwift

struct MovieDetailDummyModel {
    let dummyInt = Int.random(in: 0...100)
    let dummyString = UUID().uuidString
    let dummyBool = Bool.random()
    let dummyDouble = Double.random(in: 0...100)
    
    func getMovieDetailModel() -> MovieDetailResponseModel {
        return MovieDetailResponseModel(genres: [MovieDetailResponseModel.Genre(id: dummyInt, name: dummyString)], title: dummyString, overview: dummyString, runtime: dummyInt, poster_path: dummyString, release_date: dummyString)
    }
    
    func getMovieReviewModel() -> MovieReviewModel {
        return MovieReviewModel(results: [MovieReviewModel.Review(author_details: MovieReviewModel.Review.authorDetail(name: dummyString, username: dummyString, avatar_path: dummyString, rating: dummyDouble), content: dummyString, created_at: dummyString, id: dummyString, updated_at: dummyString, url: dummyString)])
    }
    
    func getMovieVideoModel() -> MovieVideoResponModel {
        return MovieVideoResponModel(results: [MovieVideoResponModel.videoDetail(name: dummyString, key: dummyString, size: dummyInt, site: dummyString, official: dummyBool, type: dummyString)])
    }
    
    func getMovieCreditModel() -> MovieCreditResponseModel {
        return MovieCreditResponseModel(id: dummyInt, cast: [MovieCreditResponseModel.Cast(gender: dummyInt, id: dummyInt, name: dummyString, character: dummyString, profile_path: dummyString)], crew: [MovieCreditResponseModel.Crew(gender: dummyInt, id: dummyInt, name: dummyString, job: dummyString, department: dummyString)])
    }
}
