//
//  Color.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import UIKit

enum Colors: String {
    case AppBaseDarkBlueColor = "#2b8e8e"   // 75 194 198
    case LightGray = "#E2E2E2"              // 226 226 226
    case LightGreen = "#f0f9fa"             // 226 226 226
    case DarkGray = "#36454f"               // 54 69 79
    case OrangeBase = "#F39F1E"
    func color() -> UIColor {
        return UIColor(rgba: self.rawValue)
    }
}
