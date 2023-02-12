//
//  MovieCreditResponseModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieCreditResponseModel: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
    
    struct Cast: Codable {
        let gender: Int?
        let id: Int?
        let name: String?
        let character: String?
        let profile_path: String?
    }
    
    struct Crew: Codable {
        let gender: Int?
        let id: Int?
        let name: String?
        let job: String?
        let department: String?
    }
}
