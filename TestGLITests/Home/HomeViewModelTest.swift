//
//  HomeViewModelTest.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

@testable import TestGLI
import XCTest
import Cuckoo
import RxSwift

class HomeViewModelTest: XCTestCase {
    let mockDataSource = MockHomeDataSource()
    var viewModel: HomeViewModel?
    let disposeBag = DisposeBag()
    
    let expectedMovieList = MovieListDummyModel().getMovieListModel()
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadMovies(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.movieListResponseModel)
                    XCTAssertEqual(self.viewModel?.movieListResponseModel?.results?.first?.id, self.expectedMovieList.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).getMovies(request: any()).thenReturn(Observable.just(self.expectedMovieList))
        }

        viewModel?.loadMovies()
        verify(mockDataSource).getMovies(request: any())
        wait(for: [expected], timeout: 10)
    }
    
    func testSearchMovies(){
        let expected = expectation(description: "Observer Passed")
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.movieListResponseModel)
                    XCTAssertEqual(self.viewModel?.movieListResponseModel?.results?.first?.id, self.expectedMovieList.results?.first?.id)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).searchMovies(request: any()).thenReturn(Observable.just(self.expectedMovieList))
        }

        viewModel?.searchMovie("")
        verify(mockDataSource).searchMovies(request: any())
        wait(for: [expected], timeout: 10)
    }
}
