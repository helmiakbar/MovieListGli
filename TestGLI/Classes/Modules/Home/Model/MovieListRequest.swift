//
//  MovieListRequest.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieListRequest {
    var key: String? = Constants.apiKey
    var page: Int? = 1
    var language: String? = "en-US"
    var title: String?
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["api_key"] = key
        params["page"] = page
        params["language"] = language
        return params
    }
    
    func getParamsSearch() -> [String: Any] {
        var params = [String: Any]()
        params["query"] = title
        params["api_key"] = key
        return params
    }
    
}
