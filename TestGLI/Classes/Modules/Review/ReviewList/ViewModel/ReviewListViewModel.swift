//
//  ReviewListViewModel.swift
//  TestGLI
//
//  Created by SehatQ on 12/02/23.
//

import Foundation

class ReviewListViewModel: BaseViewModel {
    var movieReviewModel: MovieReviewModel?
    
    func getCountData() -> Int {
        return movieReviewModel?.results?.count ?? 0
    }
}
