//
//  Dictionary+Extension.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

extension Dictionary {
    func toQueryString() -> String {
        var queryString: String = ""
        for (key,value) in self {
            queryString += "\(key)=\(value)&"
        }
        return String(queryString.dropLast())
    }
}
