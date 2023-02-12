//
//  ResponseError.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import Foundation

struct ResponseError: Codable {
    let errors: [ErrorModel]?
    
    struct ErrorModel: Codable, Error {
        let title: String?
        let detail: String?
        let code: String?
        let status: Int?
    }
}

