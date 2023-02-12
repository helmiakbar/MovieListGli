//
//  MovieVideoResponModel.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

struct MovieVideoResponModel: Codable {
    let results: [videoDetail]?
    
    struct videoDetail: Codable {
        let name: String?
        let key: String?
        let size: Int?
        let site: String?
        let official: Bool?
        let type: String?
    }
    
}
