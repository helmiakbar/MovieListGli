//
//  MovieDetailDataSourceTest.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

@testable import TestGLI
import XCTest
import RxSwift
import Cuckoo

class MovieDetailDataSourceTest: XCTestCase {
    let mockDataSource = MockMovieDetailDataSource()
    let disposeBag = DisposeBag()
    let delay: TimeInterval = 5
    
    let expectedMovieDetail = MovieDetailDummyModel().getMovieDetailModel()
    let expectedMovieReview = MovieDetailDummyModel().getMovieReviewModel()
    let expectedMovieVideo = MovieDetailDummyModel().getMovieVideoModel()
    let expectedMovieCredit = MovieDetailDummyModel().getMovieCreditModel()
    
    func testGetMovieDetail() {
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovieDetail(request: any()).thenReturn(Observable.just(expectedMovieDetail))
            
        }

        mockDataSource.getMovieDetail(request: MovieDetailRequest(movieId: 0, key: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieReview() {
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovieReview(request: any()).thenReturn(Observable.just(expectedMovieReview))
            
        }

        mockDataSource.getMovieReview(request: MovieDetailRequest(movieId: 0, key: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieVideo() {
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovieVideo(request: any()).thenReturn(Observable.just(expectedMovieVideo))
            
        }

        mockDataSource.getMovieVideo(request: MovieDetailRequest(movieId: 0, key: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testGetMovieCredit() {
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovieVideo(request: any()).thenReturn(Observable.just(expectedMovieVideo))
            
        }

        mockDataSource.getMovieVideo(request: MovieDetailRequest(movieId: 0, key: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
}
