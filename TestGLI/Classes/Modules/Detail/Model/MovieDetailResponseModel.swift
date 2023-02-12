//
//  MovieDetailResponseModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieDetailResponseModel: Codable {
    let genres: [Genre]?
    let title: String?
    let overview: String?
    let runtime: Int?
    let poster_path: String?
    let release_date: String?
    
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }
}
