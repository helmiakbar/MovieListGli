//
//  MovieDetailRequest.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieDetailRequest {
    var movieId: Int
    var key: String? = Constants.apiKey
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["api_key"] = key
        
        return params
    }
}
