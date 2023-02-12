//
//  MovieDetailModelTest.swift
//  TestGLITests
//
//  Created by SehatQ on 12/02/23.
//

@testable import TestGLI
import XCTest
import Cuckoo
import RxSwift

class MovieDetailModelTest: XCTestCase {
    let mockDataSource = MockMovieDetailDataSource()
    var viewModel: MovieDetailViewModel?
    let disposeBag = DisposeBag()
    
    let expectedMovieDetail = MovieDetailDummyModel().getMovieDetailModel()
    let expectedMovieReview = MovieDetailDummyModel().getMovieReviewModel()
    let expectedMovieVideo = MovieDetailDummyModel().getMovieVideoModel()
    let expectedMovieCredit = MovieDetailDummyModel().getMovieCreditModel()
    
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailViewModel(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadMovieDetail() {
        let expected = expectation(description: "Observer Passed")
        viewModel?.request = MovieDetailRequest(movieId: 0, key: "")
        
        viewModel?.state.subscribe(
            onNext: {[weak self] state in
                guard let self = self else { return }
                switch state {
                case .finished:
                    XCTAssertNotNil(self.viewModel?.movieDetailModel)
                    XCTAssertNotNil(self.viewModel?.movieReviewModel)
                    XCTAssertNotNil(self.viewModel?.movieCreditModel)
                    XCTAssertNotNil(self.viewModel?.movieVideoModel)
                    
                    XCTAssertEqual(self.viewModel?.movieDetailModel?.title, self.expectedMovieDetail.title)
                    XCTAssertEqual(self.viewModel?.movieReviewModel?.results?.first?.id, self.expectedMovieReview.results?.first?.id)
                    XCTAssertEqual(self.viewModel?.movieCreditModel?.id, self.expectedMovieCredit.id)
                    XCTAssertEqual(self.viewModel?.movieVideoModel?.results?.first?.name, self.expectedMovieVideo.results?.first?.name)
                    expected.fulfill()
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        
        stub(mockDataSource) { stub in
            when(stub).getMovieDetail(request: any()).thenReturn(Observable.just(self.expectedMovieDetail))
        }
        stub(mockDataSource) { stub in
            when(stub).getMovieVideo(request: any()).thenReturn(Observable.just(self.expectedMovieVideo))
        }
        stub(mockDataSource) { stub in
            when(stub).getMovieCredit(request: any()).thenReturn(Observable.just(self.expectedMovieCredit))
        }
        stub(mockDataSource) { stub in
            when(stub).getMovieReview(request: any()).thenReturn(Observable.just(self.expectedMovieReview))
        }
        
        viewModel?.loadMovieDetail()
        verify(mockDataSource).getMovieDetail(request: any())
        verify(mockDataSource).getMovieReview(request: any())
        verify(mockDataSource).getMovieVideo(request: any())
        verify(mockDataSource).getMovieCredit(request: any())
        wait(for: [expected], timeout: 10)
    }
}
