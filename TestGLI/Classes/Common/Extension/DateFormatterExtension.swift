//
//  DateFormatterExtension.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import Foundation

extension DateFormatter {
    @nonobjc static var standardDateFormatter: DateFormatter = {
        let dateFormatter = Foundation.DateFormatter()
        return dateFormatter
    }()

    static func dataFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = standardDateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
