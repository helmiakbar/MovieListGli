//
//  NetworkConfiguration.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct NetworkConfiguration {
    static let DEV_BASE_URL = "https://api.themoviedb.org/"
    
    static let kTokenExpiredErrorCode = 405
    static let kGatewayTimeoutErrorCode = 503
    static let kMissingPhoneNumberErrorCode = 403
    
    static func api(_ apiType: APIUrl) -> String {
        return DEV_BASE_URL + apiType.apiString()
    }
}
