//
//  MovieReviewModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieReviewModel: Codable {
    let results: [Review]?
    
    struct Review: Codable {
        let author_details: authorDetail?
        let content: String?
        let created_at: String?
        let id: String?
        let updated_at: String?
        let url: String?

        struct authorDetail: Codable {
            let name: String?
            let username: String?
            let avatar_path: String?
            let rating: Double?
        }
    }
}
