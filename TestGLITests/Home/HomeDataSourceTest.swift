//
//  HomeDataSourceTest.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

@testable import TestGLI
import XCTest
import RxSwift
import Cuckoo

class HomeDataSourceTest: XCTestCase {
    let mockDataSource = MockHomeDataSource()
    let disposeBag = DisposeBag()
    let delay: TimeInterval = 5
    
    let expectedMovieList = MovieListDummyModel().getMovieListModel()
    
    func testGetMovies(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).getMovies(request: any()).thenReturn(Observable.just(expectedMovieList))
            
        }

        mockDataSource.getMovies(request: MovieListRequest(key: "", page: 0, language: "", title: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
    
    func testSearchMovies(){
        let expected = expectation(description: "Observer Passed")

        stub(mockDataSource) { stub in
            when(stub).searchMovies(request: any()).thenReturn(Observable.just(expectedMovieList))
            
        }

        mockDataSource.searchMovies(request: MovieListRequest(key: "", page: 0, language: "", title: "")).subscribe(
            onNext: { response in
                expected.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expected], timeout: delay)
    }
        
}
